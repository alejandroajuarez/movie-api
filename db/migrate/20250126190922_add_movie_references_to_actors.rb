class AddMovieReferencesToActors < ActiveRecord::Migration[7.2]
  def change
    # add_reference :actors, :movie, null: false, foreign_key: true
  end
end
