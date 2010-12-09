Given /^the following tracks:$/ do |tracks|
  Track.create!(tracks.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) track$/ do |pos|
  visit tracks_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following tracks:$/ do |expected_tracks_table|
  expected_tracks_table.diff!(tableish('table tr', 'td,th'))
end
