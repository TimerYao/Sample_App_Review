class HelpsController < ApplicationController

  def new
    @help = Help.new
  end

  def index
    @helps = Help.all
  end

  def create
    @help = Help.new(help_params)
    if @help.save
      flash[:success] = "发布成功"
      redirect_to helps_path
    else
      render 'new'
    end
  end

  private

    def help_params
        params.require(:help).permit(:title, :mobile, :content)
    end
end
