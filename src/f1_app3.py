import streamlit as st
import mysql.connector
import pandas as pd
import plotly.express as px
from PIL import Image
import base64
import hashlib

# Set page config and background
st.set_page_config(page_title="Formula 1 Database", page_icon=":racing_car:", layout="wide")

# Database connection function
@st.cache_resource
def init_connection():
    return mysql.connector.connect( # change configurations accordingly
        host="localhost",
        user="root",
        password="", #enter password here
        database="f1",
        port=3307
    )

conn = init_connection()

# Function to run SQL queries
@st.cache_data
def run_query(query):
    with conn.cursor() as cur:
        cur.execute(query)
        return cur.fetchall()

# Function to hash passwords
def hash_password(password):
    return hashlib.sha256(password.encode()).hexdigest()

# Function to verify login
def verify_login(username, password):
    hashed_password = hash_password(password)
    users = {
        "USER@F1": hash_password("USER@F1"),
        "ADMIN@F1": hash_password("ADMIN@F1")
    }
    return username in users and users[username] == hashed_password

# Function to get base64 encoded image
def get_base64_of_image(image_path):
    with open(image_path, "rb") as img_file:
        return base64.b64encode(img_file.read()).decode()



# Add F1 logo
f1_logo = Image.open("C:/Users/krish/OneDrive/Desktop/DBMS PROJECT/logo.png")  
st.image(f1_logo, width=200)

# Background image
background_image = get_base64_of_image("C:/Users/krish/OneDrive/Desktop/DBMS PROJECT/back.jpg") 
st.markdown(
    f"""
    <style>
    .stApp {{
        background-image: url("data:image/png;base64,{background_image}");
        background-size: cover;
    }}
    </style>
    """,
    unsafe_allow_html=True
)

# Login system
if 'logged_in' not in st.session_state:
    st.session_state.logged_in = False
    st.session_state.is_admin = False

if not st.session_state.logged_in:
    st.title('Welcome to Formula 1 Database')
    username = st.text_input("Username")
    password = st.text_input("Password", type="password")
    if st.button("Login"):
        if verify_login(username, password):
            st.session_state.logged_in = True
            st.session_state.is_admin = (username == "ADMIN@F1")
            st.experimental_user
        else:
            st.error("Invalid username or password")
else:
    # Main app logic
    st.title('Formula 1 Interactive Database App')

    # Sidebar for navigation
    page = st.sidebar.selectbox("Choose a page", ["Drivers", "Constructors", "Circuits", "Race Results", "Championships"])

    if page == "Drivers":
        st.header("Drivers")
        
        # Dropdown to select a specific driver
        drivers = run_query("SELECT Driver_ID, CONCAT(Fname, ' ', Lname) as Name FROM driver_list")
        driver_options = {f"{driver[1]} ({driver[0]})": driver[0] for driver in drivers}
        selected_driver = st.selectbox("Select a driver", list(driver_options.keys()))
        selected_driver_id = driver_options[selected_driver]
        
        # Display driver details
        driver_details = run_query(f"SELECT * FROM driver_list WHERE Driver_ID = {selected_driver_id}")
        if driver_details:
            df_driver = pd.DataFrame(driver_details, columns=["Driver_ID", "Fname", "Lname", "DOB", "Nationality", "Team"])
            st.table(df_driver)
        
        # Display driver's fastest laps
        fastest_laps = run_query(f"""
            SELECT c.Circuit_Name, f.Time
            FROM fastest_lap f
            JOIN circuit c ON f.Circuit_ID = c.Circuit_ID
            WHERE f.Driver_ID = {selected_driver_id}
        """)
        if fastest_laps:
            df_fastest_laps = pd.DataFrame(fastest_laps, columns=["Circuit", "Time"])
            st.subheader("Fastest Laps")
            fig = px.bar(df_fastest_laps, x="Circuit", y="Time", title="Fastest Laps by Circuit")
            st.plotly_chart(fig)
        
        # Input field to update driver's points (only for admin)
        if st.session_state.is_admin:
            new_points = st.number_input("Update driver's points", min_value=0)
            if st.button("Update Points"):
                run_query(f"UPDATE driver_champs SET Points = {new_points} WHERE Driver_ID = {selected_driver_id}")
                st.success("Points updated successfully!")

    elif page == "Constructors":
        st.header("Constructors")
        
        # Dropdown to select a specific constructor
        constructors = run_query("SELECT Const_ID, Team_Name FROM constructor_list")
        constructor_options = {const[1]: const[0] for const in constructors}
        selected_constructor = st.selectbox("Select a constructor", list(constructor_options.keys()))
        selected_const_id = constructor_options[selected_constructor]
        
        # Display constructor details
        const_details = run_query(f"SELECT * FROM constructor_list WHERE Const_ID = '{selected_const_id}'")
        if const_details:
            df_const = pd.DataFrame(const_details, columns=["Const_ID", "Team_Name", "Base_Location", "Engine_Used"])
            st.table(df_const)
        
        # Display constructor's drivers and their points
        const_drivers = run_query(f"""
            SELECT dl.Fname, dl.Lname, dc.Points
            FROM driver_list dl
            JOIN driver_champs dc ON dl.Driver_ID = dc.Driver_ID
            WHERE dl.Team = '{selected_constructor}'
        """)
        if const_drivers:
            df_const_drivers = pd.DataFrame(const_drivers, columns=["First Name", "Last Name", "Points"])
            st.subheader("Team Drivers and Points")
            fig = px.bar(df_const_drivers, x="Last Name", y="Points", title="Driver Points")
            st.plotly_chart(fig)

    elif page == "Circuits":
        st.header("Circuits")
        
        # Dropdown to select a specific circuit
        circuits = run_query("SELECT Circuit_ID, Circuit_Name FROM circuit")
        circuit_options = {circ[1]: circ[0] for circ in circuits}
        selected_circuit = st.selectbox("Select a circuit", list(circuit_options.keys()))
        selected_circuit_id = circuit_options[selected_circuit]
        
        # Display circuit details
        circuit_details = run_query(f"SELECT * FROM circuit WHERE Circuit_ID = '{selected_circuit_id}'")
        if circuit_details:
            df_circuit = pd.DataFrame(circuit_details, columns=["Circuit_ID", "Circuit_Name", "Circuit_Location", "Circuit_Length"])
            st.table(df_circuit)
        

    elif page == "Race Results":
        st.header("Race Results")
        
        # Display all fastest laps
        fastest_laps = run_query("""
            SELECT c.Circuit_Name, CONCAT(d.Fname, ' ', d.Lname) as Driver, fl.Time
            FROM fastest_lap fl
            JOIN circuit c ON fl.Circuit_ID = c.Circuit_ID
            JOIN driver_list d ON fl.Driver_ID = d.Driver_ID
        """)
        df_fastest_laps = pd.DataFrame(fastest_laps, columns=["Circuit", "Driver", "Time"])
        st.subheader("Fastest Laps")
        fig = px.scatter(df_fastest_laps, x="Circuit", y="Time", color="Driver", title="Fastest Laps by Circuit and Driver")
        st.plotly_chart(fig)

    elif page == "Championships":
        st.header("Championships")
        
        # Display driver championship standings
        driver_standings = run_query("""
            SELECT CONCAT(d.Fname, ' ', d.Lname) as Driver, dc.Points
            FROM driver_champs dc
            JOIN driver_list d ON dc.Driver_ID = d.Driver_ID
            ORDER BY dc.Points DESC
        """)
        df_driver_standings = pd.DataFrame(driver_standings, columns=["Driver", "Points"])
        st.subheader("Driver Championship Standings")
        fig_drivers = px.bar(df_driver_standings, x="Driver", y="Points", title="Driver Championship Points")
        st.plotly_chart(fig_drivers)
        
        # Display constructor championship standings
        const_standings = run_query("""
            SELECT cl.Team_Name, cc.Points
            FROM const_champs cc
            JOIN constructor_list cl ON cc.Const_ID = cl.Const_ID
            ORDER BY cc.Points DESC
        """)
        df_const_standings = pd.DataFrame(const_standings, columns=["Constructor", "Points"])
        st.subheader("Constructor Championship Standings")
        fig_constructors = px.bar(df_const_standings, x="Constructor", y="Points", title="Constructor Championship Points")
        st.plotly_chart(fig_constructors)

    # Logout button
    if st.sidebar.button("Logout"):
        st.session_state.logged_in = False
        st.session_state.is_admin = False
        st.experimental_user