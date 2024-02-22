require "micrate"

@[ACONA::AsCommand("db:migrate")]
@[ADI::Register]
class Blog::Commands::DBMigrate < ACON::Command
  protected def execute(input : ACON::Input::Interface, output : ACON::Output::Interface) : ACON::Command::Status
    Micrate::Cli.run_up

    Status::SUCCESS
  end
end
