BeforeAll {
    Import-Module Trilium
}

Describe 'Connect-TriliumAuth' {
    It 'Login successful'{
        $login = Connect-TriliumAuth -baseURL 'https://notes.phunky1.com' -EtapiToken $CredsTrilium
        $login.appVersion | Should -Not -BeNullOrEmpty   
    }
}

Describe 'Get-TriliumRootNote' {
    It 'Returns data for root note' {
        $note = Get-TriliumRootNote
        $note.noteId | Should -Be 'root'
    }
}

Describe 'Find-TriliumNote' {
    It 'Finds a note based on a term'{
        $found = Find-TriliumNote -Search 'configs'
        $found | Should -Not -BeNullOrEmpty
    }
}

Describe 'Get-TriliumNoteDetail' {
    It 'Gets the details from noteID' {
        $details = Get-TriliumNoteDetail -NoteID '3C6jxiSFSDtg'
        $details.noteId | Should -Be '3C6jxiSFSDtg'
    }
}

