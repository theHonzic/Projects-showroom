import hashlib
from flask import Blueprint, redirect, render_template, request, session, url_for, flash
import auth
import forms
import config
from service.user_service import UserService
from service.employee_type_service import EmployeeTypeService

users = Blueprint('users', __name__)


@users.route("/list")
@auth.login_required
@auth.roles_required("Admin")
def user_list():
    users = UserService.get_users()
    return render_template("users/list.jinja", users = users)

@users.route("/new", methods=["GET", "POST"])
@auth.roles_required('Admin')
@auth.login_required
def user_new():
    form = forms.NewEmployeeForm(request.form)
    empoyee_types = EmployeeTypeService.get_all()
    form.employee_type.choices = [(item['id_employee_type'], item['role']) for item in empoyee_types]
    
    
    
    if request.method == "POST":
        hashed_password = hashlib.sha256(request.form['password'].encode()+config.PASSWORD_SALT.encode()).hexdigest()
        UserService.add_employee(
            first_name=request.form['first_name'],
            last_name=request.form['last_name'],
            email=request.form['email'],
            phone_number=request.form['phone_number'],
            password=hashed_password,
            hourly_wage=request.form['hourly_wage'],
            role=request.form['employee_type']
        )
        flash('Employee created')
        return redirect(url_for('users.user_list'))
    return render_template("users/new.jinja", form=form)

def prepopulate_user(user, form):
    empoyee_types = EmployeeTypeService.get_all()
    form.employee_type.choices = [(item['id_employee_type'], item['role']) for item in empoyee_types]
    form.first_name.data = user['first_name']
    form.last_name.data = user['last_name']
    form.email.data = user['email']
    form.phone_number.data = user['phone_number']
    form.hourly_wage.data = user['hourly_wage']
    form.employee_type.default = user['id_employee_type']
    return form

@users.route("/detail", methods=["GET", "POST"])
@auth.login_required
def user_detail():
    user = UserService.get_user(request.args.get('id'))
    ## Admin editing users
    if session['admin'] == 1:
        form=prepopulate_user(user=user, form=forms.EditEmployeeForm(request.form))
        
        if request.method == "POST":
            if user['role'] != None:
                UserService.edit_employee(
                    user['id_user'],
                    request.form['first_name'],
                    request.form['last_name'],
                    request.form['email'],
                    request.form['phone_number'],
                    request.form['hourly_wage'],
                    request.form['employee_type'],
                    1)
                flash("Employee edited")
            else:
                UserService.edit_customer(
                    user['id_user'],
                    request.form['first_name'],
                    request.form['last_name'],
                    request.form['email'],
                    request.form['phone_number'],
                    1)
                flash("Customer edited")
            return redirect(url_for('users.user_list'))
        
        return render_template("users/detail.jinja", user = user, form=form)
    ## User editing themselves
    elif session['id_user'] == user['id_user']:
        form=prepopulate_user(user=user, form=forms.EditEmployeeForm(request.form))
        if request.method == "POST":
            if user['role'] != None:
                UserService.edit_employee(
                user['id_user'],
                request.form['first_name'],
                request.form['last_name'],
                request.form['email'],
                request.form['phone_number'],
                request.form['hourly_wage'],
                request.form['employee_type'],
                1)
                flash("Employee edited")
                return redirect(url_for('users.user_detail', id = user['id_user']))
            else:
                UserService.edit_customer(
                user['id_user'],
                request.form['first_name'],
                request.form['last_name'],
                request.form['email'],
                request.form['phone_number'],
                0)
                flash("Customer edited")
                return redirect(url_for('users.user_detail', id = user['id_user']))
        return render_template("users/detail.jinja", user = user, form=form)
    else:
        return redirect(url_for('users.user_detail', id=session['id_user']))



@users.route("/delete")
@auth.login_required
@auth.roles_required("Admin")
def user_delete():
    UserService.delete_user(request.args.get('id', None, int))
    return redirect(url_for('users.user_list'))

@users.route("/block")
@auth.login_required
@auth.roles_required("Admin")
def user_block():
    UserService.block(value = request.args.get('value'), id = request.args.get('id', None, int))
    return redirect(url_for('users.user_list'))