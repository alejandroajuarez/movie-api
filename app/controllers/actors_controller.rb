class ActorsController < ApplicationController
  def index
    @actors = Actor.includes(:movie) 
    render json: @actors, include: { movie: { only: [:title, :year, :plot, :image_url] } }
  end

  def show
    @actor = Actor.includes(:movie).find_by(id: params[:id])
    if @actor
      render json: @actor, include: { movie: { only: [:title, :year, :plot, :image_url] } }
    else
      render json: { error: "Actor not found" }, status: :not_found
    end
  end

  def create
    @actor = Actor.new(
      first_name: params[:input_fname],
      last_name:  params[:input_lname],
      known_for:  params[:input_known_for],
      movie_id:   params[:movie_id]
    )

    if @actor.save
      render json: @actor, include: { movie: { only: [:title, :year, :plot, :image_url] } }
    else
      render json: { errors: @actor.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @actor = Actor.find_by(id: params[:id])
    if @actor
      @actor.update(
        first_name: params[:first_name] ||  @actor.first_name,
        last_name:  params[:last_name]  ||  @actor.last_name,
        known_for:  params[:known_for]  ||  @actor.known_for,
        movie_id:   params[:movie_id]   ||  @actor.movie_id
      )
      render json: @actor, include: { movie: { only: [:title, :year, :plot, :image_url] } }
    else
      render json: { error: "Actor not found" }, status: :not_found
    end
  end

  def destroy
    @actor = Actor.find_by(id: params[:id])
    if @actor
      @actor.destroy
      render json: { message: "Actor deleted successfully" }
    else
      render json: { error: "Actor not found" }, status: :not_found
    end
  end
  
end
