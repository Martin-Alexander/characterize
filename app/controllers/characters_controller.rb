require 'json'

class CharactersController < ApplicationController
  before_action :set_character, only: [:show, :destroy]

  def new
    @character = Character.new
    create
  end

  def create
    # @sentence = generate
    @character = Character.new(character_params)

    if current_user
      @character.user = current_user
      if @character.save
        redirect_to characters_path
      else
        redirect_to root, notice: "Something went wrong, please try again"
      end
    else
      redirect_to new_user_session
    end
  end

  def show
  end

  def index
    @user = current_user
    @characters = Character.where(user: current_user)
  end

  def destroy
    @character.destroy
    redirect_to characters_path(current_user)
  end

  private

  def set_character
    @character = Character.find(params[:id])
  end

  def character_params
    params.require(:character).permit(:name, :race, :job, :location, :trait, :quirk, :story)
  end

end
