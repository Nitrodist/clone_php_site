require 'nokogiri'
require 'ruby-progressbar'

directory = '/var/www'

total_files = Dir["#{directory}/**/*"].length

progress_bar = ProgressBar.create(:title => "In-doc ? items", :starting_at => 0, :total => total_files)

# Remove the question marks from inside the files
Dir.foreach(directory) do |file_name_string|

  # Skip current and parent directory files
  next if file_name_string == '.' or file_name_string == '..'

  begin
    file = File.read("#{directory}/#{file_name_string}")
  rescue Errno::EISDIR
    next
  end

  # Load the document into a Nokogiri HTML Doc for manipulation
  doc = Nokogiri::HTML(file)
  file = nil

  # Modify every link found by removing the question mark
  doc.xpath('//a').each do |link|
    link.attributes["href"].value = link.attributes["href"].value.gsub(/\?/, '')
  end

  # Save the file
  File.open("#{directory}/#{file_name_string}", 'w') {|f| f.write(doc) }
  progress_bar.increment
end

progress_bar.finish

total_files = Dir["#{directory}/**/*"].length

progress_bar = ProgressBar.create(:title => "Docs moving", :starting_at => 0, :total => total_files)

# Move the files such that they don't have question marks in them anymore
Dir.foreach(directory) do |file_name_string|

  # Skip current and parent directory files
  next if file_name_string == '.' or file_name_string == '..'

  # Move le files
  `mv #{directory}/#{file_name_string} #{directory}/#{file_name_string.gsub(/\?/, '')}` unless "#{directory}/#{file_name_string}" == "#{directory}/#{file_name_string.gsub(/\?/, '')}" || file_name_string.include?('(')

  progress_bar.increment

end

progress_bar.finish

puts "We're done!"
