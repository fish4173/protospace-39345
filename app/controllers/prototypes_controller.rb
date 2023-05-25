class PrototypesController < ApplicationController
  # authenticate_user!を利用してログインしていない状態ではプロトタイプ新規投稿ページ、
  # プロトタイプ編集ページ、プロトタイプ削除機能に遷移出来ないようにする。
  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  before_action :authorize_user!, only: [:edit]

  def index
    @prototypes =Prototype.all
  end

  def new
    @prototype = Prototype.new
    # Prototypeテーブルのデータを生成
  end

  def create
   @prototype=Prototype.new(prototype_params)
   if @prototype.save
    redirect_to root_path(@prototype)
    else
    render :new
   end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end

  def update
    @prototype = Prototype.find(params[:id])

    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype)
    else
      render :edit
    end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end


  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept,:image).merge(user_id: current_user.id)
  end

  def authorize_user!
    @prototype = Prototype.find(params[:id])
    unless current_user == @prototype.user
      redirect_to root_path
    end
  end


end
