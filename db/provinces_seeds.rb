# db/seeds/provinces_seeds.rb

provinces = [
  { province_name: "Alberta", hst: 0.0, gst: 0.05, pst: 0.00 },
  { province_name: "British Columbia", hst: 0.0, gst: 0.05, pst: 0.07 },
  { province_name: "Manitoba", hst: 0.0, gst: 0.05, pst: 0.07 },
  { province_name: "New Brunswick", hst: 0.15, gst: 0.00, pst: 0.00 },
  { province_name: "Newfoundland and Labrador", hst: 0.15, gst: 0.00, pst: 0.00 },
  { province_name: "Northwest Territories", hst: 0.0, gst: 0.05, pst: 0.00 },
  { province_name: "Nova Scotia", hst: 0.15, gst: 0.00, pst: 0.00 },
  { province_name: "Nunavut", hst: 0.0, gst: 0.05, pst: 0.00 },
  { province_name: "Ontario", hst: 0.13, gst: 0.00, pst: 0.00 },
  { province_name: "Prince Edward Island", hst: 0.15, gst: 0.00, pst: 0.00 },
  { province_name: "Quebec", hst: 0.0, gst: 0.05, pst: 0.0975 },
  { province_name: "Saskatchewan", hst: 0.0, gst: 0.05, pst: 0.06 },
  { province_name: "Yukon", hst: 0.0, gst: 0.05, pst: 0.00 }
]

Province.create!(provinces)
