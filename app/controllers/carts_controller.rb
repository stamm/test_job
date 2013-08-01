class CartsController < AuthController
  before_action :set_cart, only: [:show, :edit, :update, :destroy]

  # GET /carts/1
  # GET /carts/1.json
  def show
    if @cart.line_items.empty?
      redirect_to root_path, notice: 'Empty cart'
      return
    end
  end

  # GET /carts/new
  def new
    @cart = Cart.new
  end

  # PATCH/PUT /carts/1
  # PATCH/PUT /carts/1.json
  def update
    respond_to do |format|
      saved = @cart.update_attributes(cart_params)
      @cart.line_items.select{ |item| item.quantity <= 0 }.map(&:destroy)
      if saved
        format.html { redirect_to @cart, notice: 'Cart was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { redirect_to @cart, notice: 'Cart wasn\'t updated.' }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carts/1
  # DELETE /carts/1.json
  def destroy
    @cart.destroy
    session[:cart_id] = nil
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Your cart is empty' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart
      begin
        @cart = current_cart
        if @cart.id != params[:id].to_i
          redirect_to root_url, notice: 'Not yours Cart'
        end
      rescue ActiveRecord::RecordNotFound
        redirect_to root_url, notice: 'Unexisting Cart'
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cart_params
      params.require(:cart).permit(line_items_attributes: [:quantity, :product_id, :id])
    end
end
