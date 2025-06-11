BeforeAll {
    Import-Module Trilium
    $script:QuickNotes = 'Ke5cfQwGUMaI'
    $Script:TestAttachmentId = 'XBEevZKDZXRe'
    $script:Connection = Connect-TriliumAuth -baseURL 'https://notes.phunky1.com' -EtapiToken $CredsTrilium
}

Describe 'Trilium Module Tests' {

    Describe 'Connect-TriliumAuth' {
        It 'Connects successfully with ETAPI token' {
            $script:Connection.appVersion | Should -Not -BeNullOrEmpty
        }
    }

    Describe 'Get-TriliumRootNote' {
        It 'Gets the root note' {
            Get-TriliumRootNote | ForEach-Object {
                $_.noteId | Should -Be 'root'
            }
        }
    }

    Describe 'New-TriliumNote' {
        It 'Creates a new note under QuickNotes' {
            $note = New-TriliumNote -Title 'Pester test' -Content 'test content' -ParentNoteId $script:QuickNotes
            $note.note.parentNoteIds | Should -Contain $script:QuickNotes
            $script:TestNoteId = $note.note.noteId
        }
    }

    Describe 'Find-TriliumNote' {
        It 'Finds the Configs note' {
            $found = Find-TriliumNote -Search 'configs'
            $found.results.title | Should -Contain 'Configs'
        }
    }

    Describe 'Get-TriliumNoteDetail' {
        It 'Returns the correct note details' {
            $details = Get-TriliumNoteDetail -NoteID $script:TestNoteId
            $details.noteId | Should -Be $script:TestNoteId
        }
    }

    Describe 'Copy-TriliumNote' {
        It 'Copies test note to root' {
            $copy = Copy-TriliumNote -NoteID $script:TestNoteId -ParentNoteID 'root'
            $copy.noteId | Should -Not -BeNullOrEmpty
            Remove-TriliumBranch -BranchID $copy.branchId
        }
    }

    Describe 'Export-TriliumNote' {
        It 'Exports a note to a zip file' {
            $exportPath = "C:\\temp\\PesterExport_$($script:TestNoteId).zip"
            Export-TriliumNote -NoteID $script:TestNoteId -Path $exportPath | Out-Null
            Test-Path $exportPath | Should -BeTrue
            Remove-Item $exportPath -ErrorAction SilentlyContinue
        }
    }

    Describe 'Get-TriliumAttachment' {
        It 'Gets an attachment by ID' {
            # $TestAttachmentId must be set to a valid attachment ID before running this test
            $result = Get-TriliumAttachment -AttachmentID $Script:TestAttachmentId
            $result | Should -Not -BeNullOrEmpty
        }
    }

}

AfterAll {
    if ($script:TestNoteId) {
        Remove-TriliumNote -NoteID $script:TestNoteId
    }
}
