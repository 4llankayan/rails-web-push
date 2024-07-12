class PushSubscriptionsController < ApplicationController
  before_action :set_push_subscription, only: %i[ show edit update destroy ]

  # GET /push_subscriptions or /push_subscriptions.json
  def index
    @push_subscriptions = PushSubscription.all
  end

  # GET /push_subscriptions/1 or /push_subscriptions/1.json
  def show
  end

  # GET /push_subscriptions/new
  def new
    @push_subscription = PushSubscription.new
  end

  # GET /push_subscriptions/1/edit
  def edit
  end

  # POST /push_subscriptions or /push_subscriptions.json
  def create
    @push_subscription = PushSubscription.new(push_subscription_params)

    respond_to do |format|
      if @push_subscription.save
        format.html { redirect_to push_subscription_url(@push_subscription), notice: "Push subscription was successfully created." }
        format.json { render :show, status: :created, location: @push_subscription }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @push_subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /push_subscriptions/1 or /push_subscriptions/1.json
  def update
    respond_to do |format|
      if @push_subscription.update(push_subscription_params)
        format.html { redirect_to push_subscription_url(@push_subscription), notice: "Push subscription was successfully updated." }
        format.json { render :show, status: :ok, location: @push_subscription }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @push_subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /push_subscriptions/1 or /push_subscriptions/1.json
  def destroy
    @push_subscription.destroy!

    respond_to do |format|
      format.html { redirect_to push_subscriptions_url, notice: "Push subscription was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_push_subscription
      @push_subscription = PushSubscription.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def push_subscription_params
      params.require(:push_subscription).permit(:endpoint, :p256dh, :auth, :subscribed)
    end
end
