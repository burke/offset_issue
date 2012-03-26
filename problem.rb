#!/usr/bin/env bundle exec rails runner
initial_ts = Time.now

def time_as_passed_in_from_forms(time)
  time.to_s(:db)
end

p = Post.create(timestamp: time_as_passed_in_from_forms(initial_ts))
puts "initial timestamp:      #{initial_ts}"

new_ts = initial_ts - initial_ts.utc_offset

puts "next timestamp:         #{new_ts}"
p.timestamp = time_as_passed_in_from_forms(new_ts)
puts "Changed: #{p.timestamp_changed?}"
puts "Timestamp before save:  #{p.timestamp}"
p.save
puts "Timestamp after save:   #{p.timestamp}"
p.reload
puts "Timestamp after reload: #{p.timestamp}"

__END__

example output:

initial timestamp:      2012-03-26 15:23:42 -0500
next timestamp:         2012-03-26 20:23:42 -0500
Changed: false
Timestamp before save:  2012-03-26 20:23:42 -0500
Timestamp after save:   2012-03-26 20:23:42 -0500
Timestamp after reload: 2012-03-26 15:23:42 -0500

Things to note here are:
  1) Rails is configured to use Central time (my time zone)
  2) I set the timestamp initially to the current time and saved the object
  3) I then set the timestamp to the existing value minus the UTC offset, using a string with no timezone specified.
  4) This appears to work, and changes the time on the object.
  5) It does not register as changed, despite having manually assigned to the field, thus, saving does not persist the field.

