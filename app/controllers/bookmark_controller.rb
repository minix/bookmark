class BookmarkController < ApplicationController
  def index
    @bookmark = Bookmark.find(:all)
    @user = User.find_by_id(session[:user])
    #@tag = Bookmark.find_by_sql("select tag from bookmarks group by tag order by count(tag) DESC")
    #@tag = Bookmark.find(:all, :select => "tag", :group => "tag", :order => "count(tag) DESC")
    @tag = Bookmark.find(:all, :select => "tag", :group => "tag")
    #@tag_count = Bookmark.where(:tag => "#{@tag.tag}").count
#    @tag.each do |tag_count|
#      @tag_count = Bookmark.where(:tag => "#{tag_count.tag}").count
#    end
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

  def profile
  end

end
