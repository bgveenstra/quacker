class TweetsController < ApplicationController

  def index
    @tweets = Tweet.all
    respond_to do |format|
      format.json { render :json=> @tweets }
      format.html {
        if current_user
          @tweets=Tweet.all
          @following = current_user.following
        else
          @tweets=Tweet.all
          render :index
        end
      }
    end
  end

  def new
    @tweet = Tweet.new
    render :new
  end

  def create
    @tweet = Tweet.create(tweet_params)
    @user = current_user
    # @user.tweets << @tweet
    # redirect_to user_path(@user)
    redirect_to tweets_path
  end

  def show
    @tweets = Tweet.all
    @tweet = Tweet.find(params[:id])
    @comments = @tweet.comments
    @following = current_user.following
    render :show
  end

  def update
    @tweet = Tweet.find(params[:id])
    # if current_user == @tweet.user
    #   @tweet.update(tweet_params)
    # else
    #   flash[:notice]="Not your tweet!"
    # end
    @tweet.update(tweet_params)
    redirect_to tweets_path
  end

  def edit
    @tweet = Tweet.find(params[:id])
    # if current_user == @tweet.user
    #   render :edit
    # else
    #   flash[:notice]="Not your tweet!"
    #   redirect_to tweets_path
    # end
    render :edit
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    if current_user == @tweet.user
      @tweet.destroy
    else
      flash[:notice]= "Not Your tweet!"
    end
    redirect_to tweets_path
  end

  def like
    @tweet = Tweet.find(params[:id])
    @tweet.liked_by current_user

    if request.xhr?
      head :ok
    else
      redirect_to @tweet
    end
  end

  def dislike
    @tweet = Tweet.find(params[:id])
    @tweet.disliked_by current_user
    redirect_to @tweet
  end

  private

  def tweet_params
    params.require(:tweet).permit(:title, :body, :latitude, :longitude)
  end

end
