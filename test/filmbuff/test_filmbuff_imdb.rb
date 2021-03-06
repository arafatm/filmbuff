require_relative '../test_helper'

describe FilmBuff::IMDb do
  before do
    @imdb = FilmBuff::IMDb.new
  end

  describe '#find_by_id' do
    before do
      @title = @imdb.find_by_id('tt0032138')
    end

    it 'returns a Title' do
      assert_instance_of FilmBuff::Title, @title
    end
  end

  describe '#find_by_title' do
    describe 'with default options' do
      before do
        @titles = @imdb.find_by_title('The Wizard of Oz')
      end

      it 'returns an array of titles' do
        assert_instance_of Array, @titles
      end
    end

    describe 'given a limit of 3' do
      before do
        @titles = @imdb.find_by_title('The Wizard of Oz', limit: 3)
      end

      it 'returns 3 results' do
        assert_equal 3, @titles.size
      end
    end

    describe 'when only returning popular titles' do
      before do
        @title = @imdb.find_by_title('The Wizard of Oz',
                                     types: %w(title_popular))
      end

      it 'returns the 1939 version' do
        assert_equal '1939', @title.first[:release_year]
      end
    end
  end
end
