class MastersController < ApplicationController
  layout 'layouts/single_column'

  def index
    @circles = Circle.all.map { |circle|
      if circle.master_circle
        circle.master_circle
      else
        Master::Circle.create(circle_id: circle.id, total_score: 0)
      end
    }.sort_by(&:total_score)
  end
end
