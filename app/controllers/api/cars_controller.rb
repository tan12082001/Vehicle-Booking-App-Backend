class Api::CarsController < ApplicationController
  before_action :authenticate_api_user!
  before_action :find_car, only: %i[show destroy]

  def index
    @cars = Car.where(deleted_at: nil)
    render json: @cars
  end

  def show
    render json: @car
  end

  def create
    @car = Car.new(car_params)

    if @car.save
      render json: @car, status: :created, location: api_all_cars_path
    else
      render json: @car.errors, status: :unprocessable_entity
    end
  end

  def destroy
    # Instead of deleting, mark as deleted
    if @car
      @car.update(deleted_at: Time.now)
      render json: { message: 'Car marked as removed' }
    else
      render json: { error: 'Car not found' }, status: :not_found
    end
  end

  private

  def find_car
    @car = Car.find(params[:id])
  end

  def car_params
    params.require(:car).permit(:name, :description, :image, :pricePerHr, :seating_capacity, :rental_duration)
  end
end
