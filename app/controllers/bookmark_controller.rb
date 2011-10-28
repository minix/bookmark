class BookmarkController < ApplicationController
  def index
    @bookmark = Bookmark.find(:all)
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

end
