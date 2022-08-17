# Parser class
# The main purpose of this class is to receive a log file
# and calculate two things:
# - Total views of every page
# - Total unique views of every page
class Parser
  def initialize(log)
    @total_views = Hash.new(0)
    @unique_views = Hash.new(0)

    log_file = self.check_and_get_log_file(log)
    process_log_file(log_file)
    log_file.close
  end

  # Validates given log file and returns FILE object
  #
  # @param query [String, log] Passed internally
  # @return [FILE] Returns File object
  def check_and_get_log_file(log)
    if log.empty?
      raise "Log file is required!"
    end

    if File.exist?(log) == false
      raise "Given log file does not exist!"
    end

    log_file = File.open(log, "r")

    return log_file
  end

  # Process the items in the log files
  #
  # @param query [String, log] Passed internally
  def process_log_file(log_file)
    log_file.each_line do |item|
      data = item.split(" ")

      @total_views[data[0]] += 1

      unique_key = "#{data[0]}--#{data[1]}"
      # Only count unique views
      if @unique_views.key?(unique_key) == false
        @unique_views[unique_key] += 1
      end
    end
  end

  # Get total number of views per page, in the order: max to min
  def get_total_page_views()
    total_views = @total_views.sort_by(&:last).reverse
    total_views.each do |page, views|
      puts "#{page}  #{views} visits"
    end
  end

  # Get total number of unique views per page, in the order: max to min
  def get_total_page_unique_views()
    pages_unique_views = Hash.new(0)
    @unique_views.each do |page, views|
      page_arr = page.split("--")
      pages_unique_views[page_arr[0]] += views
    end

    pages_unique_views = pages_unique_views.sort_by(&:last).reverse
    pages_unique_views.each do |page, views|
      puts "#{page}  #{views} unique views"
    end
  end
end
