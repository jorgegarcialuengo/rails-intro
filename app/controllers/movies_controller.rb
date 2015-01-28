class MoviesController < ApplicationController


  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @movies =[] 
    @chosenRatings =[] 
    @all_ratings = Movie.allRatings
 
   
    
    if !params[:ratings] # dindt hit params, so its the first session or taped in orderBy
      
      if (params[:orderBy])
        #raise params[:ratings].inspect
        @movies = Movie.find(:all, :order=>params[:orderBy], :conditions=>{:rating => session[:ratings].keys})
        session[:orderBy] = params[:orderBy]
        @chosenRatings = session[:ratings].keys
     
      elsif session[:ratings]  
        # raise params[:ratings].inspect
        flash.keep
        @chosenRatings = session[:ratings].keys
        redirect_to movies_path(:sort => params[:orderBy], :ratings => session[:ratings])

      else # firt session
        #raise params[:ratings].inspect

        @movies = Movie.all
        @chosenRatings = Movie.allRatings

      end

    else # params[:ratings]
      #raise params[:ratings].inspect
      session[:ratings] = params[:ratings]
      session[:orderBy] = params[:orderBy]
      @movies = Movie.find(:all, :order=>params[:orderBy], :conditions=>{:rating => session[:ratings].keys})
      @chosenRatings = session[:ratings].keys

    end
    
      
     # if session[:ratings] 
       # raise params[:ratings].inspect

      #  @movies
       # flash.keep
        #@chosenRatings = session[:ratings]
        #redirect_to movies_path #(:sort => params[:orderBy], :rating => @chosenRatings)
      #else # there is no session, first entry

      #end
     
    #else # params[:ratings] is not empty
    # raise params[:ratings].inspect 
     # session[:ratings] = params[:ratings].keys
      #@movies = Movie.find(:all, :order=>session[:orderBy], :conditions=>{:rating => session[:ratings]})
      #@chosenRatings = params[:ratings].keys  
    #end 

   # if params[:orderBy] == 'releaseDate'
      # sort by date
      #@movies = Movie.order(:release_date)
    #  @movies = Movie.find(:all, :order=>params[:orderBy, :conditions=>{:rating => session[:ratings]})
     # @chosenRatings = session[:ratings]
    #elsif params[:orderBy] == 'title'
      # sort by title
      # @movies = Movie.order(:title)
     # @movies = Movie.find(:all, :order=>:title, :rating => session[:ratings])
      #@chosenRatings = session[:ratings]
    # elsif session[:ratings]
      # session[:ratings].each {|rate| 
      # @movies = @movies + Movie.where(rating: rate)
      # @chosenRatings = @chosenRatings + [rate]}

  #  else # nitial entry
   #   @movies = Movie.all
    #  @chosenRatings = Movie.allRatings
   # end
   	
  end



  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
