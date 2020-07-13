class OrdersController < ApplicationController
  before_action :authenticate_user!, except: [:notify]

  def preload
    bead = Bead.find(params[:bead_id])
    today = Date.today
    orders = bead.orders.where("start_date >= ? OR end_date >= ?", today, today)

    render json: orders

  end

  def preview
    # start_date = Date.parse(params[:start_date])
    # end_date = Date.parse(params[:end_date])

    # output = {
    #   conflict: is_conflict(start_date, end_date)
    # }
    # render json: output
  end

  def create
    @order = current_user.orders.create(order_params)

    if @order

      # send request to PayPal
      values = {
        business: 'lawrencemurry@yahoo.com',
        cmd: '_xclick',
        upload: 1,
        notify_url: 'https://https://b2e7c852a8a946beaff428d059503c03.vfs.cloud9.us-east-1.amazonaws.com/notify',
        amount: @order.total,
        item_name: @order.bead.listing_name,
        item_number: @order.id,
        quantity: '1',
        return: 'https:/https://b2e7c852a8a946beaff428d059503c03.vfs.cloud9.us-east-1.amazonaws.com//your_trips' #'http://########.ngrok.io/your_trips'
      }

      redirect_to "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
    else
      redirect_to @order.bead, alert: "Oops, something went wrong..."
    end
  end

  protect_from_forgery except: [:notify]
  def notify
    print 'hello'
    params.permit!
    status = params[:payment_status]

    order = Order.find(params[:item_number])

    if status == "Completed"
      order.update_attributes status: true
    else
      order.destroy
    end

    render nothing: true
  end

  protect_from_forgery except: [:your_trips]
  def your_trips
    @trips = current_user.orders.where("status = ?", true)
  end

  def your_orders
    @beads = current_user.beads
  end

  private
    def is_conflict
      @bead = Bead.find(params[:bead_id])

      # check = bead.orders.where("? < start_date AND end_date < ?", start_date, end_date)
      check.size > 0 ? true : false
    end
    def order_params
      params.require(:order).permit(:price, :total, :bead_id)
    end
end