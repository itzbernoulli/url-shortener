class LinksController < ApplicationController

    def index
        get_links
        @link = Link.new
    end

    def best_hundred
        @links = Link.order(clicked: :desc).paginate(page: params[:page], per_page: 20,total_entries: 100)
    end

    def new
        @link = Link.new
    end

    def create
        @link = Link.new(link_params)
        respond_to do |format|
            if @link.save
                format.js
            else
                flash[:error] = @link.errors.full_messages
                get_links
                format.html { render :index }
            end
        end
    end

    def show
        @link = Link.find_by_slug(params[:slug])
        return render file: 'public/404.html', status: :not_found, layout: false if @link.nil?
        @link.update_attribute(:clicked, @link.clicked + 1)
        redirect_to @link.url
    end

    private

    def link_params
        params.require(:link).permit(:url, :slug)
    end

    def get_links
        @links = Link.order(created_at: :desc).paginate(page: params[:page], per_page: 30)
    end
end