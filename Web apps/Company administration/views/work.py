from flask import Blueprint, flash, redirect, render_template, request, session, url_for
import auth
import forms
from service.component_service import ComponentService
from service.telephone_service import TelephoneService
from service.user_service import UserService



work = Blueprint('work', __name__)


@work.route("/list")
@auth.login_required
@auth.roles_required('Assembler')
def work_list():
    my_work = TelephoneService.get_telephones_made_by(request.args.get('id'))
    work = TelephoneService.get_telephones_made_by(request.args.get('id'))
    total: float = 0
    
    id_employee = UserService.get_employee_by_id(session['id_user'])['id_employee']
    
    for item in my_work:
        total += float(item['workload'])
    total *= float(item['hourly_wage'])
    
    return render_template("work/my_work_list.jinja", work=work, total=round(total, 2), id_employee=id_employee)

@work.route("/build", methods = ["GET", "POST"])
@auth.login_required
@auth.roles_required("Assembler")
def build():
    form = forms.BuildPhoneForm(request.form)
    id_employee = request.args.get('id_employee')
    id_telephone = request.args.get('id_telephone')
    
    telephone = TelephoneService.get_by_id(id=id_telephone)
    
    
    if request.method == "POST":
        components = ComponentService.get_telephone_components(telephone['id_telephone'])
        ok = True
        
        for item in components:
            current = ComponentService.get_by_id(item['id_component'])
            goes_in = item['piece_count']
            diff = item['piece_count']-goes_in
            if diff < 0:
                ok = False
            
        if ok == True:
            for item in components:
                current = ComponentService.get_by_id(item['id_component'])
                goes_in = item['piece_count']
                diff = item['piece_count']-goes_in
                ComponentService.change_count(current['id_component'], diff)
                
            UserService.work(
                    id_employee=id_employee,
                    id_telephone=id_telephone,
                    hours_spent=request.form['hours_spent']
                )
            flash("success")
            return redirect(url_for('homepage.index'))
        else:
            flash("Not enough components")
            return redirect(url_for('homepage.index'))
    return render_template("work/build.jinja", id_employee=id_employee, telephone=telephone, form = form)

@work.route("/new", methods = ["GET", "POST"])
@auth.login_required
@auth.roles_required("Assembler")
def new_work():
    form = forms.WorkOnNew(request.form)
    id_employee = request.args.get('id_employee')
    telephones = TelephoneService.get_all()
    form.id_telephone.choices = [(item['id_telephone'], item['model']) for item in telephones]
    if request.method == "POST":
        components = ComponentService.get_telephone_components(id=request.form['id_telephone'])
        ok = True
        
        for item in components:
            current = ComponentService.get_by_id(item['id_component'])
            goes_in = item['piece_count']
            diff = item['piece_count']-goes_in
            if diff < 0:
                ok = False
            
        if ok == True:
            for item in components:
                current = ComponentService.get_by_id(item['id_component'])
                goes_in = item['piece_count']
                diff = item['piece_count']-goes_in
                ComponentService.change_count(current['id_component'], diff)
                
            UserService.work(
                    id_employee=id_employee,
                    id_telephone=request.form['id_telephone'],
                    hours_spent=request.form['hours_spent']
                )
            return redirect(url_for('homepage.index'))
        else:
            flash("Not enough components")
            return redirect(url_for('homepage.index'))
                
    return render_template("work/new.jinja", form = form)