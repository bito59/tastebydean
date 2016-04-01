class PoubellesController < ApplicationController

  def index
    @grid = PoubellesGrid.new(params[:poubelles_grid]) do |scope|
      scope.page(params[:page])
    end
  end

end

