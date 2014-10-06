class LaunchersController < ApplicationController
  def index
    @launchers = Launcher.all
  end

  def new
    @launcher = Launcher.new
  end

  def create
    @launcher = Launcher.new(launcher_params)
    @launcher.save
    redirect_to launchers_path,
      notice: "Success! The Launcher was added."
  end

  private

  def launcher_params
    params.require(:launcher).permit(:first_name, :last_name, :email, :bio)
  end
end
