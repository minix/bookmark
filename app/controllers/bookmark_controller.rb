class BookmarkController < ApplicationController
  def index
    @bookmark = Bookmark.find(:all)
    @list_name = Bookmark.find(:all, :select => "bm_user_id")
    @user = User.find_by_id(session[:user])
    #@tag = Bookmark.find_by_sql("select tag from bookmarks group by tag order by count(tag) DESC")
    #@tag = Bookmark.find(:all, :select => "tag", :group => "tag", :order => "count(tag) DESC")
    @tag = Bookmark.find(:all, :select => "tag", :group => "tag")
    @list_name.each do |username|
      @username = User.find_by_id("username")
    end
  end

  def new
    @bookmark = Bookmark.new

    respond_to do |format|
      format.html
      format.json { render :json => @bookmark }
    end
  end

  def create
    @bookmark = Bookmark.new(params[:bookmark])
    @user = User.find_by_id(session[:user])
    @bookmark.bm_user_id = @user.id
#    if :url !~ /^[http:\/\/|https:\/\/].*/
#      :url => 'http://' + :url
#    end

    respond_to do |format|
      if @bookmark.save
        format.html { redirect_to :action => "index", :notice => 'Bookmark Save! ' }
        format.json { render :json => @bookmark, :status => :created, :locate => @bookmark }
      else
        format.html { render :action => "new" }
        format.json { render :json => @bookmark.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy

    redirect_to :action => "index"

  end

  def modify
    @bookmark = Bookmark.find(params[:id])
  end

  def login
    if request.post?
      if session[:user] = User.authenticate(params[:user][:name], params[:user][:password])
        flash[:message] = "login successful"
        #redirect_to_stored
        redirect_to :controller => "bookmark", :action => "index"
      else
        flash[:warning] = "login unsuccessful"
      end
    end
  end

  def profile
    @user = User.find_by_id(session[:user])
    @url = Bookmark.where(:bm_user_id => "#{@user.id}")
    @bookmark = Bookmark.find(:all)
    @list_name = Bookmark.find(:all, :select => "bm_user_id")
    @user = User.find_by_id(session[:user])
    @tag = Bookmark.find(:all, :select => "tag", :group => "tag")
    @list_name.each do |username|
      @username = User.find_by_id("username")
    end
  end

end
