import hashlib
from flask import Blueprint, render_template, session, redirect, url_for, request, flash
import config
import auth
import forms
from service.user_service import UserService

auth_bp = Blueprint('auth', __name__)


@auth_bp.route('/signin', methods=['GET', 'POST'])
def sign_in():
    form = forms.SignInForm(request.form)
    if request.method == 'POST':
        user = UserService.verify(email=request.form['email'], password=request.form['password'])
        if not user:
            flash('Incorrect email or password')
        else:
            if user['registration_completed'] == 1 and user['blocked'] == 0:
                session['authenticated'] = 1
                session['first_name'] = user['first_name']
                session['last_name'] = user['last_name']
                session['email'] = user['email']
                session['role'] = user['role']
                session['admin'] = user['admin']
                session['id_user'] = user['id_user']
                session['id_employee'] = user['id_employee']
                return redirect(url_for('homepage.index'))
            else:
                if user['blocked']:
                    flash("Your account has been blocked.")
                else:
                    flash("Your registration is pending. Please wait for us to complete it.")
    return render_template("auth/sign_in.jinja", form=form)


@auth_bp.route('/signout')
@auth.login_required
def signout():
    session.pop("authenticated")
    session.pop("email")
    session.pop("role")
    session.pop("first_name")
    session.pop("admin")
    session.pop("last_name")
    session.pop("id_user")
    session.pop("id_employee")
    return redirect(url_for('homepage.index'))


@auth_bp.route("/new_customer", methods=["POST", "GET"])
def new_customer():
    form = forms.NewCustomerForm(request.form)
    if request.method == "POST":
        UserService.add_customer(
            first_name=request.form['first_name'],
            last_name=request.form['last_name'],
            email=request.form['email'],
            phone_number=request.form['phone_number'],
            password=hashlib.sha256(request.form['password'].encode()+config.PASSWORD_SALT.encode()).hexdigest()
            
        )
        flash("Your registration is being processed. You will be able to continue in no time.")
        return redirect(url_for('homepage.index'))
    return render_template('auth/new_customer.jinja', form=form)

@auth_bp.route("/confirm_customer_registration")
@auth.login_required
@auth.roles_required('Admin')
def confirm_customer_registration():
    UserService.complete_customer_registration(request.args.get('id'))
    flash("Registration confirmed.")
    return redirect(url_for('users.user_list'))