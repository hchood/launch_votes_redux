class LaunchersController < ApplicationController
  def index
    @launchers = Launcher.all
  end

  def new
    @launcher = Launcher.new
  end

  def create
    @launcher = Launcher.new(launcher_params)
    if @launcher.save
      redirect_to launchers_path,
        notice: "Success! The Launcher was added."
    else
      flash.now[:notice] = "Oh no! Launcher could not be saved."
      render 'new'
    end
  end

  private

  def launcher_params
    params.require(:launcher).permit(:first_name, :last_name, :email, :bio)
  end
end
