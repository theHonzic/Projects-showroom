from flask import Blueprint, flash, redirect, render_template, request, url_for
import flask
import auth
import forms
from service.component_service import ComponentService
from service.telephone_service import TelephoneService

telephones = Blueprint('telephones', __name__)


@telephones.route("/list")
@auth.login_required
def telephone_list():
    telephones = TelephoneService.get_all()
    return render_template("telephones/list.jinja", telephones = telephones)

@telephones.route("/new", methods=["GET", "POST"])
@auth.roles_required('Admin')## ještě někdo asi, asi by šla udělat nějaká fukce v auth.py
@auth.login_required
def telephone_new():
    form = forms.NewTelephoneForm(request.form)
    
    if request.method == "POST":
        TelephoneService.insert_telephone(
            model=request.form['model'],
            workload=request.form['workload'],
            price_constant=request.form['price_constant']
        )
        flash('Model created')
        return redirect(url_for('telephones.telephone_list'))
    return render_template("telephones/new.jinja", form=form)



@telephones.route("/detail")
def telephone_detail():
    telephone = TelephoneService.get_by_id(request.args.get('id', None, int))
    components = ComponentService.get_telephone_components(request.args.get('id'))
    piece_count = TelephoneService.get_telephone_count(request.args['id'])
    piece_count = piece_count['count']
    units = TelephoneService.get_units(request.args['id'])
    price_base = telephone['price_constant'] * telephone['workload']
    price_for_components = 0
        
    for item in components:
        price_for_components += item['piece_count'] * item['price']
        
    manufacture_cost = price_base+price_for_components
    sale_cost = manufacture_cost * 1.1
    return render_template("telephones/detail.jinja", telephone = telephone, components=components, piece_count=piece_count, telephones=units, manufacture_cost=round(manufacture_cost, 2), sale_cost = round(sale_cost, 2))

@telephones.route("/add_component", methods=["POST", "GET"])
@auth.roles_required("Admin")
def add_components():
    components = ComponentService.get_all()
    id_telephone = request.args.get('id')
    telephone = TelephoneService.get_by_id(request.args.get('id'))
    form = forms.AddComponentToTelephone(request.form)
    form.id_component.choices = [(item['id_component'], item['name']) for item in components]    
    if request.method == "POST":
        ComponentService.add_component_to_telephone(
            id_component=request.form['id_component'],
            count=request.form['piece_count'],
            id_telephone=id_telephone
            )
        return redirect(url_for('telephones.telephone_detail', id = id_telephone))
    return render_template("telephones/add_component.jinja", form=form, telephone=telephone)