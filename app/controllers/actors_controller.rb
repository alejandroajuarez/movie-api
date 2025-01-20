class ActorsController < ApplicationController
  def index
    actor = Actor.all
    render :index
  end

  def show
    id_find = params[:id]
    @actor = Actor.find_by(id: id_find)
    render :show
  end

  def create
    @actor = Actor.new(
      first_name: params[:input_fname],
      last_name:  params[:input_lname],
      known_for:  params[:input_known_for]
    )
    @actor.save
    render :show
  end

  def update
    @actor = Actor.find_by(id: params[:id])
    @actor.first_name = params[:first_name]
    @actor.last_name = params[:last_name]
    @actor.known_for = params[:known_for]
    render :show
  end

  def destroy
    actor = Actor.find_by(id: params[:id])
    actor.destroy
    redner json: { message: "You have deleted this actor field!" }
  end
end