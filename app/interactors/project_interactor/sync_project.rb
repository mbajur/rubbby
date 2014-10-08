module ProjectInteractor
  class SyncProject
    include Interactor::Organizer

    organize SyncGithub, SyncRubygem
  end
end