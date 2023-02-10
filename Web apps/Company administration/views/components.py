from flask import Blueprint, render_template, session, redirect, url_for, request, flash

import auth
import forms
from service.component_service import ComponentService

components = Blueprint('components', __name__)

@components.route("/list")
@auth.login_required
@auth.roles_required("Admin", "Warehouse worker", "Assembler")
def component_list():
    components=ComponentService.get_all()
    return render_template("components/list.jinja", components=components)

@components.route("/detail")
@auth.login_required
@auth.roles_required("Admin", "Warehouse worker", "Assembler")
def component_detail():
    component = ComponentService.get_by_id(request.args.get('id'))
    telephones = ComponentService.get_telephones_with_component(request.args.get('id'))
    return render_template("components/detail.jinja", component=component, telephones=telephones)

@components.route("/increase", methods = ["GET", "POST"])
@auth.roles_required("Warehouse worker")
def increase_components():
    component = ComponentService.get_by_id(request.args.get('id'))
    form = forms.IncreaseComponentCountForm(request.form)
    if request.method == "POST":
        count = int(component['pieces_available']) + int(request.form['count'])
        ComponentService.change_count(id = component['id_component'], count=count)
    
        flash('Count increased')
        return redirect(url_for('components.component_list'))
    return render_template('components/increase.jinja', form = form, component = component)

@components.route("/new", methods = ["GET", "POST"])
@auth.login_required
@auth.roles_required("Admin", "Warehouse worker")
def new_component():
    form = forms.NewComponent(request.form)
    
    if request.method == "POST":
        ComponentService.new_component(
            name=request.form['name'],
            price=request.form['price'],
            pieces_available=request.form['pieces_available']
        )
        flash('Component created')
        return redirect(url_for('components.component_list'))
    return render_template('components/new.jinja', form = form)

@components.route("/delete")
@auth.login_required
@auth.roles_required("Admin", "Warehouse worker")
def component_delete():
    ComponentService.delete_component(request.args.get('id'))
    flash('Component deleted')
    return redirect(url_for('components.component_list'))