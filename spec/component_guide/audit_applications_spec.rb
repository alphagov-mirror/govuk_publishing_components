require "rails_helper"
require_relative "../../app/models/govuk_publishing_components/audit_applications.rb"

describe "Auditing the components in applications" do
  it "returns correct information" do
    application = GovukPublishingComponents::AuditApplications.new("#{Dir.pwd}/spec/dummy", "an application")

    expected = {
      name: "an application",
      application_found: true,
      components_found: [
        {
          location: "templates",
          components: ["contextual breadcrumbs", "contextual footer", "contextual sidebar", "error summary", "feedback", "govspeak", "input", "layout footer", "layout for admin", "layout header", "skip link", "tabs", "title"],
        },
        {
          location: "stylesheets",
          components: %w[all],
        },
        {
          location: "print_stylesheets",
          components: %w[all],
        },
        {
          location: "javascripts",
          components: %w[all],
        },
        {
          location: "ruby",
          components: [],
        },
      ],
    }

    expect(application.data).to match(expected)
  end
end
