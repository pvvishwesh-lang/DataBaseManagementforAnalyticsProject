import streamlit as st
from sqlalchemy import text,create_engine
import bcrypt
import os
import uuid
from dotenv import load_dotenv
import pandas as pd
import datetime as dt
from datetime import datetime, timedelta,date
from pymongo import MongoClient
import json
import plotly.express as px
from bson import ObjectId

def dataframe_visualizer(df, key_prefix):
    st.subheader("Visualizations")
    chart_type = st.selectbox("Select a chart type", ["Bar Chart", "Line Chart", "Pie Chart"],key=f"{key_prefix}_chart_type")
    numeric_cols = df.select_dtypes(include=['int64', 'float64']).columns.tolist()
    all_cols = df.columns.tolist()
    x_col = st.selectbox("Select X-axis column", all_cols, key=f"{key_prefix}_x_col")
    if chart_type in ["Bar Chart", "Line Chart"] and numeric_cols:
        y_col = st.selectbox("Select Y-axis column", numeric_cols, key=f"{key_prefix}_y_col")
    else:
        y_col = None
    if chart_type == "Bar Chart":
        fig = px.bar(df, x=x_col, y=y_col)
        st.plotly_chart(fig)
    elif chart_type == "Line Chart":
        fig = px.line(df, x=x_col, y=y_col)
        st.plotly_chart(fig)
    elif chart_type == "Pie Chart":
        fig = px.pie(df, names=x_col)
        st.plotly_chart(fig)

try:
    load_dotenv('/Users/vishweshpv/Downloads/Database Management for analytics /app.env') # Using a env file to store creds
    engine_uri = f"mysql+pymysql://{os.environ['mysqluser']}:{os.environ['mysqlpass']}@{os.environ['mysqlhost']}/{os.environ['mysqldb']}?autocommit=true" #using sqlalchemy to read since it is pandas recommended way
    connection=create_engine(engine_uri)# COnnection string creation
    print("Connected to MySQL!")
except Exception as e:
    print("Error while connecting to MySQL: ", e)

try:
    client=MongoClient(os.environ['mongodbhost'])#connection string creation
    db_name=os.environ['mongodb']
    db=client[db_name]
    print("Connected to MongoDB!")
except Exception as e:
    print("Error while connecting to MongoDB: ", e)  


def sql_query_visualizer():
    st.subheader('My SQL Query Result Visualization')
    if "run_sql_queries" not in st.session_state:
        st.session_state.run_sql_queries = False
    if st.button("Run Predefined SQL Queries & Visualize"):
        st.session_state.run_sql_queries = True
    if st.session_state.run_sql_queries:
        df1=pd.read_sql('''select a.Account_ID,a.FirstName,a.LastName,a.UserName,a.Email,a.Password_Hashed,a.Phone_Number,
                        b.Address1,b.Address2,b.City,b.State,b.Country,b.Age,b.Profile_Img,b.Is_Student,b.Student_ID
                        from Accounts a
                        inner join Users b on a.Account_ID=b.Account_ID''',connection)
        df2=pd.read_sql('''select a.Account_ID,a.FirstName,a.LastName,a.UserName,a.Email,a.Password_Hashed,a.Phone_Number,
                       b.Role
                       from Accounts a
                       inner join admin_records b on a.Account_ID=b.Account_ID''',connection)
        df3=pd.read_sql(''' select a.Account_ID,a.FirstName,a.LastName,a.UserName,a.Email,
                        b.Address1,b.Address2,b.City,b.State,b.Country,b.Age,b.Profile_Img,b.Is_Student,b.Student_ID,
                        d.Booking_ID,d.group_size,d.Reservation_Date,d.Status,
                        e.Payment_ID,e.Amount,e.Currency,e.Payment_Method,e.Transaction_Date,e.Payment_Reference
                        from Accounts a
                        inner join Users b on a.Account_ID=b.Account_ID
                        inner join Booking_Payment c on
                        b.Account_ID=c.Account_ID
                        inner join Bookings d on c.Booking_ID=d.Booking_ID
                        inner join Payments e on c.Payment_ID=e.Payment_ID''',connection)
        df4=pd.read_sql('''select b.Account_ID, a.FirstName, a.LastName, a.UserName,a.Email,
                       d.Feedback_ID,d.Rating,d.Comments,
                       f.place_ID,f.Name,f.Description,f.Location,f.City,f.State,f.Country,f.Opening_Time,f.Closing_Time,f.Contact_Info,f.Total_Spots
                       from Accounts a
                       inner join Users b on a.Account_ID=b.Account_ID
                       inner join User_Feedback c on b.Account_ID=c.Account_ID
                       inner join Feedback d on c.Feedback_ID=d.Feedback_ID
                       inner join PublicPlace_Feedback e on d.Feedback_ID=e.Feedback_ID
                       inner join public_places f on e.Place_ID=f.place_ID''',connection)
        df5=pd.read_sql('''select b.Account_ID, a.FirstName, a.LastName, a.UserName,a.Email,
                       d.Notification_ID,d.Title,d.Message,d.Type,d.Priority,d.Delivery_Method,d.Sent_at,d.Status
                       from Accounts a
                       inner join Users b on a.Account_ID=b.Account_ID
                       inner join Notifies_users c on b.Account_ID=c.Account_ID
                       inner join Notifications d on c.Notification_ID=d.Notification_ID''',connection)
        df6=pd.read_sql('''select a.spot_id, a.Spot_Name,a.Capacity,a.Current_Count,a.Status,a.Last_Updated,
                       b.place_ID,b.Name,b.Description,b.Location,b.City,b.State,b.Country,b.Opening_Time,b.Closing_Time,b.Contact_Info,b.Total_Spots,
                       d.Time_Slot_ID,d.Start_Time,d.End_Time,d.Max_Capacity,d.Booked_Count,
                       e.Space_Category_ID,e.Category_Name
                       from Spots_Availability a
                       inner join Public_Places b on a.Place_ID=b.Place_ID
                       inner join SpotAvailability_Checks_Time_Slots c on a.Spot_ID=c.Spot_ID
                       inner join Time_Slots d on c.Time_Slot_ID=d.Time_Slot_ID
                       left join space_categories e on b.Space_Category_ID=e.Space_Category_ID''',connection)
        df7=pd.read_sql('''select a.Log_ID,a.Log_Date,a.Visitor_Count,a.Total_Sales,a.Trash_Level,a.Notes,
                       b.place_ID,b.Name,b.Description,b.Location,b.City,b.State,b.Country,b.Opening_Time,b.Closing_Time,b.Contact_Info,b.Total_Spots
                       from daily_operational_log a
                       inner join public_places b on a.Log_ID=b.Log_ID''',connection)#inner join/outer join
        
        df8=pd.read_sql('''select * from audit_logging''',connection)#simple query
        df9=pd.read_sql('''select booking_id,AVG(amount) as average_amt from payments group by booking_id''',connection)#aggregate
        df10=pd.read_sql('''select * from Bookings where Booking_ID in(select Booking_ID from Payments where status in ('succeeded','pending')) ''',connection)#nested query
        df11=pd.read_sql('''select * from Users u1 where (select count(b1.Account_ID) from Booking_Payment b1 where b1.Account_ID=u1.Account_ID)>2 ''',connection)#correlated subquery
        df12=pd.read_sql('''select * from Users u where exists(select 1 from Booking_Payment bp JOIN Payments p on bp.Payment_ID=p.Payment_ID where bp.Account_ID=u.Account_ID and  p.status='failed')''',connection) #exists clause
        df13=pd.read_sql('''select account_id from Accounts union select account_id from Users where is_student=1''',connection)
        df14=pd.read_sql('''select place_id,name,location,(select trash_level from DAILY_OPERATIONAL_LOG dol where pp.LOG_ID = dol.LOG_ID ) as trash_level from public_places pp''',connection)#in select clause
        df15=pd.read_sql('''select Account_ID,Name,Email,Phone_Number,Address,Age FROM(select a.Account_ID,concat(a.FirstName,' ',a.LastName) as Name,a.Email,a.PHONE_NUMBER,concat(u.Address1,' ',u.Address2,' ',u.City,' ',u.State,' ',u.Country) as Address,u.AGE from users u join accounts a on u.ACCOUNT_ID =a.ACCOUNT_ID )t''',connection)#in from clause
        queries=[
            ('Selecting only Accounts that are regular users',df1,'df1'),
            ('Selecting only Accounts that are Admins',df2,'df2'),
            ('Selecting Users who made booking and then paid for it',df3,'df3'),
            ('Selecting Users who have given a feedback and to which place',df4,'df4'),
            ('Selecting Users who recieved a notification',df5,'df5'),
            ('Selecting Spots which have timeslots and the places they are in',df6,'df6'),
            ('Daily Operations per place',df7,'df7'),
            ('Audit Logs',df8,'df8'),
            ('Average Payment Amount per Booking',df9,'df9'),
            ('Bookings with Successful or Pending Payments',df10,'df10'),
            ('Users with More Than Two Bookings',df11,'df11'),
            ('Users with Failed Payments',df12,'df12'),
            ('Union of Account IDs from Accounts and Student Users',df13,'df13'),
            ('Public Places with Trash Levels from Daily Operational Logs',df14,'df14'),
            ('User Details with Concatenated Address',df15,'df15')
        ]

        for title,df,key_prefix in queries:
            st.subheader(title)
            filter_col=st.selectbox(f"Select filter column for ({title}",df.columns.tolist(),key=f"{key_prefix}_filter_col")
            filtered_df=df.copy()
            if df[filter_col].dtype==object:
                filter_value=st.text_input(f"Filter value for {filter_col}",key=f"{key_prefix}_filter_value")
                if filter_value:
                    filtered_df=df[df[filter_col].astype(str).str.contains(filter_value, case=False)]
                st.dataframe(filtered_df)
                dataframe_visualizer(filtered_df, key_prefix=key_prefix)
                    

def nosql_query_visualizer():
    st.subheader('My NoSQL Query Result Visualization')
    if "run_nosql_queries" not in st.session_state:
        st.session_state.run_nosql_queries = False
    if st.button("Run Predefined NoSQL Queries & Visualize"):
        st.session_state.run_nosql_queries = True
    if st.session_state.run_nosql_queries:
        query1=list(db.Audit_Logging.find({}))
        query2=list(db.Payments.find({'$and':[{'Amount':{'$gt':200}},{'Status':'succeeded'},{'Payment_Method':'cash'},{'Currency':'USD'}]},{'Payment_ID':1,'Booking_ID':1,'Amount':1,'Status':1,'Payment_Method':1,'Currency':1}))
        query3=list(db.Daily_Operational_Log.aggregate([{'$group':{'_id':'$Trash_Level','CountVisitors':{'$sum':'$Visitor_Count'}}},{'$sort':{'CountVisitors':-1}}]))                                    
        df1=pd.DataFrame(query1)
        df2=pd.DataFrame(query2)
        df3=pd.DataFrame(query3)
        for df in [df1,df2,df3]:
                for col in df:
                    if df[col].dtype==object and isinstance(df[col].iloc[0],ObjectId): #handling objectid type 
                        df[col]=df[col].astype(str)
        queries=[
            ('Audit Logs',df1,'df1'),
            ('Identifying Successful payments done with cash and in USD, which is more that $200',df2,'df2'),
            ('Grouping by Trash Level with respect to visitor count',df3,'df3')
        ]

        for title,df,key_prefix in queries:
            st.subheader(title)
            filter_col=st.selectbox(f"Select filter column for ({title}",df.columns.tolist(),key=f"{key_prefix}_filter_col")
            filtered_df=df.copy()
            if df[filter_col].dtype==object:
                filter_value=st.text_input(f"Filter value for {filter_col}",key=f"{key_prefix}_filter_value")
                if filter_value:
                    filtered_df=df[df[filter_col].astype(str).str.contains(filter_value, case=False)]
                st.dataframe(filtered_df)
                dataframe_visualizer(filtered_df, key_prefix=key_prefix)

st.title("SpotEase")
db_choice=st.radio("Select Database Type:",['SQL','NoSQL'])

#SQL Query
if db_choice=='SQL':
    tables=pd.read_sql("SHOW TABLES;",connection)
    table_list=tables.iloc[:,0].values.tolist()
    selected_table=st.selectbox("Select a table",table_list)
    userinputsqlquery=st.text_input('Enter your SQL query: ',value='')
    if userinputsqlquery=='':#query input processing
        if selected_table:
            st.subheader(f"Table: {selected_table}")
            df=pd.read_sql(f"SELECT * FROM {selected_table};",connection)
            st.dataframe(df)
    else:
        st.subheader(f'SQL Query Output: ')
        df=pd.read_sql(userinputsqlquery,connection)#converting to pd dataframe
        cols=pd.Series(df.columns)
        for i in range(len(cols)):
            if cols[i] in cols[:i].values:#check to see if there are dup cols in query
                cols[i]=cols[i] + f'_Dup{i}'#handling dup columns
        df.columns=cols
        st.dataframe(df)
    if not df.empty:
        dataframe_visualizer(df, key_prefix="sql_query")

#Creates a simple one page local webpage to query data from database
#use streamlit run app.py in terminal
elif db_choice=='NoSQL':#query like this {"Feedback_ID":  "FB00022"}
    collections=db.list_collection_names()
    selected_collection=st.selectbox("Select a collection",collections)
    if selected_collection:
        collection=db[selected_collection]
        print(collection.find_one())
    userinputnosqlquery=st.text_input('Enter your NoSQL query: ',value='{}')

    if userinputnosqlquery:#query input processing
        st.subheader(f'NoSQL Query Output: ')
        try:
            query_obj=json.loads(userinputnosqlquery)
            print(query_obj)
        except:
            st.error("Invalid NoSQL Query!")
            st.stop()
        is_aggregate=isinstance(query_obj,list)
        is_find=isinstance(query_obj,dict)
        if is_aggregate:
            try:
                results=list(collection.aggregate(query_obj))
            except Exception as e:
                st.error(f"Error in aggregation query: {e}")
                st.stop()
        elif is_find:
            try:
                results=list(collection.find(query_obj))
            except Exception as e:
                st.error(f"Error in find query: {e}")
                st.stop()
        else:
            st.error("Query must be a JSON object for find or a list of stages for aggregation.")
            st.stop()
        if results:
            df=pd.DataFrame(results)#converting to pd dataframe
            for col in df.columns:
                if df[col].dtype==object and isinstance(df[col].iloc[0],ObjectId): #handling objectid type 
                    df[col]=df[col].astype(str)
            st.dataframe(df)
            dataframe_visualizer(df, key_prefix="nosql_query")

        else:
            st.write("No results found!")
    
else:
    print('Unavailable!')

if db_choice=='SQL':
    sql_query_visualizer()
elif db_choice=='NoSQL':
    nosql_query_visualizer()


#eg query: {"$and": [{"Amount" : {"$gt" : 200} }, {"Currency" : {"$eq": "USD"}}, {"Payment_Method":"cash"}]}

#mongobd starter: sudo mongod --dbpath=/Users/vishweshpv/data/db

# streamlit run app.py

#[{"$group":{"_id":"$Payment_ID","total_payments":{"$sum":"$Amount"}}},{"$sort":{"total_payments":-1}}]
