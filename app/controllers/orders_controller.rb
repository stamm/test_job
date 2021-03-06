class OrdersController < AuthController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all_include.order_by_create.page(params[:page]).per(10)
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end


  # POST /orders
  # POST /orders.json
  def create
    @cart = current_cart

    if @cart.line_items.empty?
      redirect_to root_path, notice: 'Empty cart'
      return
    end

    @order = Order.new
    @order.user = current_user
    @order.add_line_items_from_cart(current_cart)

    respond_to do |format|
      notice = []
      begin
        saved = @order.save_with_transaction
      rescue Exception => e
        notice = [e.message] || ['Error with order saving.']
      end
      if saved
        session[:cart_id] = nil
        format.html { redirect_to root_path, notice: 'Order was successfully created.' }
        format.json { render action: 'show', status: :created, location: @order }
      else
        notice = @order.errors.to_a unless @order.errors.empty?
        format.html { redirect_to @cart, notice: notice.join('.') }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit()
    end
end
