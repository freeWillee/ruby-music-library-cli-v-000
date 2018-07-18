class MusicLibraryController

  def initialize(path = "./db/mp3s")
    object = MusicImporter.new(path)
    object.import
  end

  def call
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"

    action = gets.strip

    if action == "exit"
      "exit"
    else
      self.call
    end

  end

  def list_songs
    i = 1
    array_of_songs = Song.all.sort_by {|song| song.name}
    array_of_songs.each do |song|
      puts "#{i}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
      i += 1
    end
    array_of_songs
  end

  def list_artists
    i = 1
    array_of_artists = Artist.all.sort_by {|artist| artist.name}
    array_of_artists.each do |artist|
      puts "#{i}. #{artist.name}"
      i += 1
    end
  end

  def list_genres
    i = 1
    array_of_genres = Genre.all.sort_by {|genre| genre.name}
    array_of_genres.each do |genre|
      puts "#{i}. #{genre.name}"
      i += 1
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    user_input = gets.strip
    artist = Artist.find_by_name(user_input)
    if artist == nil
      return nil
    else
      i = 1
      song_array = artist.songs.sort_by {|song| song.name}
      song_array.each do |song|
        puts "#{i}. #{song.name} - #{song.genre.name}"
        i += 1
      end
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    user_input = gets.strip
    genre = Genre.find_by_name(user_input)
    if genre == nil
      return nil
    else
      i = 1
      genre_song_array = genre.songs.sort_by {|song| song.name}
      genre_song_array.each do |song|
        puts "#{i}. #{song.artist.name} - #{song.name}"
        i += 1
      end
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    user_input = gets.strip

    song_array = self.list_songs

    # binding.pry

    if user_input.to_i > song_array.size
      return nil
    else
      selected_artist = song_array[(user_input.to_i)-1].artist.name
      selected_song = song_array[(user_input.to_i)-1].name
      puts "Playing #{selected_song} by #{selected_artist}"
    end
  end

end
