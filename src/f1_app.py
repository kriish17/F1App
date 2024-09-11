import streamlit as st
import mysql.connector
import pandas as pd

# Database connection
@st.cache_resource
def init_connection():
    return mysql.connector.connect( # MYSQL connection details -- edit as necessary
        host="localhost",
        user="root",
        password="",
        database="f1",
        port="3307"
    )

conn = init_connection()

# Function to run SQL queries
@st.cache_data
def run_query(query):
    with conn.cursor() as cur:
        cur.execute(query)
        return cur.fetchall()

# Streamlit app
st.title('Formula 1 Database App')

# Sidebar for navigation
page = st.sidebar.selectbox("Choose a page", ["Drivers", "Constructors", "Circuits", "Race Results"])

if page == "Drivers":
    st.header("Drivers")
    drivers = run_query("SELECT * FROM driver_list")
    df_drivers = pd.DataFrame(drivers, columns=["Driver_ID", "Fname", "Lname", "DOB", "Nationality", "Team"])
    st.dataframe(df_drivers)

    st.subheader("Driver Championships")
    champs = run_query("SELECT dl.Fname, dl.Lname, dc.Position, dc.Points FROM driver_champs dc JOIN driver_list dl ON dc.Driver_ID = dl.Driver_ID ORDER BY dc.Position")
    df_champs = pd.DataFrame(champs, columns=["First Name", "Last Name", "Position", "Points"])
    st.dataframe(df_champs)

elif page == "Constructors":
    st.header("Constructors")
    constructors = run_query("SELECT * FROM constructor_list")
    df_constructors = pd.DataFrame(constructors, columns=["Const_ID", "Team_Name", "Base_Location", "Engine_Used"])
    st.dataframe(df_constructors)

    st.subheader("Constructor Championships")
    const_champs = run_query("SELECT cl.Team_Name, cc.Position, cc.Points FROM const_champs cc JOIN constructor_list cl ON cc.Const_ID = cl.Const_ID ORDER BY cc.Position")
    df_const_champs = pd.DataFrame(const_champs, columns=["Team Name", "Position", "Points"])
    st.dataframe(df_const_champs)

elif page == "Circuits":
    st.header("Circuits")
    circuits = run_query("SELECT * FROM circuit")
    df_circuits = pd.DataFrame(circuits, columns=["Circuit_ID", "Circuit_Name", "Circuit_Location", "Circuit_Length"])
    st.dataframe(df_circuits)

elif page == "Race Results":
    st.header("Race Results")
    
    st.subheader("Pole Positions")
    poles = run_query("SELECT c.Circuit_Name, dl.Fname, dl.Lname, pp.Q_Time FROM pole_position pp JOIN circuit c ON pp.Circuit_ID = c.Circuit_ID JOIN driver_list dl ON pp.Driver_ID = dl.Driver_ID")
    df_poles = pd.DataFrame(poles, columns=["Circuit", "First Name", "Last Name", "Qualifying Time"])
    st.dataframe(df_poles)

    st.subheader("Fastest Laps")
    fast_laps = run_query("SELECT c.Circuit_Name, dl.Fname, dl.Lname, fl.Lap_No, fl.Time FROM fastest_lap fl JOIN circuit c ON fl.Circuit_ID = c.Circuit_ID JOIN driver_list dl ON fl.Driver_ID = dl.Driver_ID")
    df_fast_laps = pd.DataFrame(fast_laps, columns=["Circuit", "First Name", "Last Name", "Lap Number", "Lap Time"])
    st.dataframe(df_fast_laps)