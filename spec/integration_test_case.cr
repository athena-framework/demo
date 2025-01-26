# ameba:disable Lint/SpecFilename:
abstract struct IntegrationTestCase < ATH::Spec::APITestCase
  def initialize
    super

    DATABASE.exec "TRUNCATE TABLE \"articles\" RESTART IDENTITY;"
  end
end
