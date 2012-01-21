#!/usr/bin/env ruby
##########################################################################
# Giovanni Capuano <webmaster@giovannicapuano.net>
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.
##########################################################################
require 'text'

class String
	def levenshtein(b)
		Text::Levenshtein.distance(self, b)
	end
		alias :leven :levenshtein
		alias :distance :levenshtein
end

abort('No input given.') if ARGV.length == 0
input = ARGV[0].strip.downcase
force = 2
directories = ['/usr/local/bin/', '/usr/bin/']

words = []
directories.each do |path|
	begin
		tmp = Dir.entries(path)
		tmp.each do |f|
			words << f if f != '.' && f != '..' && input.levenshtein(f) <= force
		end
	rescue SystemCallError; end
end
words.uniq!

if(words.length == 0)
	puts '0 occurrences found.'
elsif(words.length == 1)
	puts "Did you mean #{words.join}?"
else
	puts "Did you mean one of these? #{words.join(' ')}"
end
