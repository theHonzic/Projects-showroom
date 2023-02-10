from wtforms import Form, IntegerField, StringField, SelectField, PasswordField, validators, FloatField

## Sign in form
class SignInForm(Form):
    email = StringField(name='email', label='Email', validators=[validators.Length(min=2, max=30), validators.InputRequired()])
    password = PasswordField(name='password', label='Password', validators=[validators.Length(min=3), validators.InputRequired()])
    

## Request customer account
class NewCustomerForm(Form):
    first_name = StringField(name="first_name", label="First name", validators=[validators.InputRequired()])
    last_name = StringField(name="last_name", label="Last name", validators=[validators.InputRequired()])
    email = StringField(name="email", label="Email", validators=[validators.InputRequired()])
    phone_number = StringField(name="phone_number", label="Phone number", validators=[validators.InputRequired()])
    password = PasswordField(name="password", label="Password", validators=[validators.InputRequired()])
    
## Create new employee
class NewEmployeeForm(Form):
    first_name = StringField(name="first_name", label="First name", validators=[validators.InputRequired()], default="")
    last_name = StringField(name="last_name", label="Last name", validators=[validators.InputRequired()])
    email = StringField(name="email", label="Email", validators=[validators.InputRequired()])
    phone_number = StringField(name="phone_number", label="Phone number", validators=[validators.InputRequired()])
    password = PasswordField(name="password", label="Password", validators=[validators.InputRequired()])
    hourly_wage = FloatField(name="hourly_wage", label="Hourly wage", validators=[validators.InputRequired()])
    employee_type = SelectField(name="employee_type", choices=[], validators=[validators.InputRequired()])
    
## Create new telephone model
class NewTelephoneForm(Form):
    model = StringField(name="model", label="Model", validators=[validators.InputRequired()])
    workload = FloatField(name="workload", label="Workload", validators=[validators.InputRequired()])
    price_constant = FloatField(name="price_constant", label="Price constant", validators=[validators.InputRequired()])
    

## Edit employee
class EditEmployeeForm(Form):
    first_name = StringField(name="first_name", label="First name", validators=[validators.InputRequired()])
    last_name = StringField(name="last_name", label="Last name", validators=[validators.InputRequired()])
    email = StringField(name="email", label="Email", validators=[validators.InputRequired()])
    phone_number = StringField(name="phone_number", label="Phone number", validators=[validators.InputRequired()])
    hourly_wage = FloatField(name="hourly_wage", label="Hourly wage", validators=[validators.InputRequired()])
    employee_type = SelectField(name="employee_type", choices=[], validators=[validators.InputRequired()])

    

## Increase component count
class IncreaseComponentCountForm(Form):
    count = IntegerField(name="count", label="Add")
    
## New Component
class NewComponent(Form):
    name = StringField(name="name", label="Name", validators=[validators.InputRequired()])
    price = FloatField(name="price", label="Price", validators=[validators.InputRequired()])
    pieces_available = IntegerField(name="pieces_available", label="Piece count", validators=[validators.InputRequired()])
    
## Add component to telephone
class AddComponentToTelephone(Form):
    id_component = SelectField(name="id_component", label="Component", choices=[], validators=[validators.InputRequired()])
    piece_count = IntegerField(name="piece_count", label="Piece count", validators=[validators.InputRequired()])
    
## Build phone
class BuildPhoneForm(Form):
    hours_spent = FloatField(name = "hours_spent", label="Hours spent", validators=[validators.InputRequired()])
    
## Work on a new phone
class WorkOnNew(Form):
    id_telephone = SelectField(name="id_telephone", label="Telephone", choices=[], validators=[validators.InputRequired()])
    hours_spent = FloatField(name = "hours_spent", label="Hours spent", validators=[validators.InputRequired()])
    
## Buy
class Buy(Form):
    piece_count = IntegerField(name="piece_count", label="Piece count", validators=[validators.InputRequired()])