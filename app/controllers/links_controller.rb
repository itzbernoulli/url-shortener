class LinksController < ApplicationController
    def index
        @links = Link.order(clicked: :desc).limit(100)
    end

    def new
        @link = Link.new
    end

    def create
        @link = Link.new(link_params)
        @link.url = @link.sanitize
        if @link.save
            # ScraperJob.perform_later(@link.id)
            redirect_to links_path
        else
            flash[:error] = @link.errors.full_messages
            redirect_to new_link_path
        end
    end

    private

    def link_params
        params.require(:link).permit(:url, :slug)
    end
end