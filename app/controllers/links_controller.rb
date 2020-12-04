class LinksController < ApplicationController
    def index
        @links = Link.all.paginate(page: params[:page], per_page: 30)
    end

    def best_hundred
        @links = Link.order(clicked: :desc).paginate(page: params[:page], per_page: 20,total_entries: 100)
    end

    def new
        @link = Link.new
    end

    def create
        @link = Link.new(link_params)
        @link.url = @link.sanitize
        if @link.save
            ScraperJob.perform_later(@link.id)
            redirect_to links_path
        else
            flash[:error] = @link.errors.full_messages
            redirect_to new_link_path
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
end