from flask import Blueprint, flash, redirect, render_template, request, url_for
from service.order_service import OrderService
import auth
import forms
from service.telephone_service import TelephoneService
orders = Blueprint('orders', __name__)


@orders.route("/list")
def order_list():
    orders = OrderService.get_all()
    return render_template("orders/list.jinja", orders = orders)


@orders.route("/detail")
def order_detail():
    items = OrderService.get_ordered_items(request.args.get('id'))
    order = OrderService.get_by_id(request.args.get('id', None, int))
    return render_template("orders/detail.jinja", order = order, items = items)


@orders.route("/dispatch")
@auth.login_required
@auth.roles_required("Warehouse worker", "Admin")
def dispatch_order():
    OrderService.dispatch_order(request.args.get('id'))
    flash("Order number "+str(request.args.get('id'))+" dispatched.")
    return redirect(url_for("orders.order_list"))

@orders.route("/buy", methods=["POST", "GET"])
@auth.login_required
def buy_telephone():
    form = forms.Buy(request.form)
    
    id_user = request.args.get('id_user')
    id_telephone = request.args.get('id_telephone')
    telephone = TelephoneService.get_by_id(request.args.get('id_telephone'))
    in_stock = TelephoneService.get_telephone_count(id_telephone)
    
    
    
    if request.method == "POST":
        pcs = request.form['piece_count']
        if int(pcs) >= 3:
            if int(in_stock['count']) < int(pcs):
                flash("Out of stock")
                return redirect(url_for('telephones.telephone_detail', id=id_telephone))
            else:
                OrderService.buy(id_user=id_user, id_telephone=id_telephone, piece_count=pcs)
                for x in range(int(pcs)):
                    TelephoneService.delete_latest(id=id_telephone)
            return redirect(url_for("telephones.telephone_list"))
        else:
            flash("You must order more than 3 pieces.")
            return redirect(url_for('telephones.telephone_detail', id=id_telephone))
        
    return render_template("orders/buy.jinja", telephone = telephone, form=form)
