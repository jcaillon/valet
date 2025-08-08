# Test suite lib-windows

## Test script 00.tests

### ✅ Testing windows::convertPathFromUnix

❯ `windows::convertPathFromUnix /tmp/file`

Returned variables:

```text
REPLY='C:\Users\TEMP\file'
```

❯ `windows::convertPathFromUnix /mnt/d/Users/username`

Returned variables:

```text
REPLY='D:\Users\username'
```

❯ `windows::convertPathFromUnix /c/data/file`

Returned variables:

```text
REPLY='C:\data\file'
```

❯ `windows::convertPathFromUnix C:\\Users\\username`

Returned variables:

```text
REPLY='C:\Users\username'
```

### ✅ Testing windows::convertPathToUnix

❯ `windows::convertPathToUnix C:\\Users\\username`

Returned variables:

```text
REPLY='/c/Users/username'
```

❯ `windows::convertPathToUnix D:\\data\\file`

Returned variables:

```text
REPLY='/d/data/file'
```

❯ `windows::convertPathToUnix /c/Users/username`

Returned variables:

```text
REPLY='/c/Users/username'
```

### ✅ Testing windows::setEnvVar

❯ `windows::setEnvVar VAR VALUE`

**Standard output**:

```text
🙈 mocking powershell: -NoProfile -NonInteractive -Command 
  $ErrorActionPreference = 'Stop';
  $processInfo = New-Object System.Diagnostics.ProcessStartInfo;
  $processInfo.FileName = "powershell.exe";
  $processInfo.Verb = "runas";
  $processInfo.RedirectStandardError = $true;
  $processInfo.RedirectStandardOutput = $true;
  $processInfo.UseShellExecute = $false;
  $processInfo.CreateNoWindow = $true;
  $processInfo.Arguments = @("-NoProfile","-NonInteractive","-Command","`$ErrorActionPreference = 'Stop'; `$key = [Microsoft.Win32.Registry]::CurrentUser.OpenSubKey('Environment', `$true); `$key.SetValue('VAR', 'VALUE', 'ExpandString');; exit `$LASTEXITCODE;")
  $p = New-Object System.Diagnostics.Process;
  $p.StartInfo = $processInfo;
  $p.Start() | Out-Null;
  $stdout = $p.StandardOutput.ReadToEnd();
  $stderr = $p.StandardError.ReadToEnd();
  $p.WaitForExit();
  $stdout | Out-File -FilePath 'tmp' -Encoding utf8;
  exit $p.ExitCode;
  
```

❯ `windows::setEnvVar VAR ''`

**Standard output**:

```text
🙈 mocking powershell: -NoProfile -NonInteractive -Command 
  $ErrorActionPreference = 'Stop';
  $processInfo = New-Object System.Diagnostics.ProcessStartInfo;
  $processInfo.FileName = "powershell.exe";
  $processInfo.Verb = "runas";
  $processInfo.RedirectStandardError = $true;
  $processInfo.RedirectStandardOutput = $true;
  $processInfo.UseShellExecute = $false;
  $processInfo.CreateNoWindow = $true;
  $processInfo.Arguments = @("-NoProfile","-NonInteractive","-Command","`$ErrorActionPreference = 'Stop'; `$key = [Microsoft.Win32.Registry]::CurrentUser.OpenSubKey('Environment', `$true); `$key.DeleteValue('VAR');; exit `$LASTEXITCODE;")
  $p = New-Object System.Diagnostics.Process;
  $p.StartInfo = $processInfo;
  $p.Start() | Out-Null;
  $stdout = $p.StandardOutput.ReadToEnd();
  $stderr = $p.StandardError.ReadToEnd();
  $p.WaitForExit();
  $stdout | Out-File -FilePath 'tmp' -Encoding utf8;
  exit $p.ExitCode;
  
```

### ✅ Testing windows::getEnvVar

❯ `windows::getEnvVar VAR`

**Standard output**:

```text
🙈 mocking powershell: -NoProfile -NonInteractive -Command 
  $ErrorActionPreference = 'Stop';
  $processInfo = New-Object System.Diagnostics.ProcessStartInfo;
  $processInfo.FileName = "powershell.exe";
  $processInfo.Verb = "runas";
  $processInfo.RedirectStandardError = $true;
  $processInfo.RedirectStandardOutput = $true;
  $processInfo.UseShellExecute = $false;
  $processInfo.CreateNoWindow = $true;
  $processInfo.Arguments = @("-NoProfile","-NonInteractive","-Command","`$ErrorActionPreference = 'Stop'; 
  `$key = [Microsoft.Win32.Registry]::CurrentUser.OpenSubKey('Environment', `$true);
  `$value = `$key.GetValue('VAR', '', 'DoNotExpandEnvironmentNames');
  `$key.Dispose();
  Write-Output `$value;
  ; exit `$LASTEXITCODE;")
  $p = New-Object System.Diagnostics.Process;
  $p.StartInfo = $processInfo;
  $p.Start() | Out-Null;
  $stdout = $p.StandardOutput.ReadToEnd();
  $stderr = $p.StandardError.ReadToEnd();
  $p.WaitForExit();
  $stdout | Out-File -FilePath 'tmp' -Encoding utf8;
  exit $p.ExitCode;
  
```

### ✅ Testing windows::addToPath

❯ `windows::addToPath /coucou`

**Standard output**:

```text
🙈 mocking powershell: -NoProfile -NonInteractive -Command 
  $ErrorActionPreference = 'Stop';
  $processInfo = New-Object System.Diagnostics.ProcessStartInfo;
  $processInfo.FileName = "powershell.exe";
  $processInfo.Verb = "runas";
  $processInfo.RedirectStandardError = $true;
  $processInfo.RedirectStandardOutput = $true;
  $processInfo.UseShellExecute = $false;
  $processInfo.CreateNoWindow = $true;
  $processInfo.Arguments = @("-NoProfile","-NonInteractive","-Command","`$ErrorActionPreference = 'Stop'; 
  `$pathToAdd = 'C:\Users\TEMP\coucou';
  `$key = [Microsoft.Win32.Registry]::CurrentUser.OpenSubKey('Environment', `$true);
  `$oldPath = `$key.GetValue('Path', '', 'DoNotExpandEnvironmentNames').TrimEnd([IO.Path]::PathSeparator);
  if (! `$oldPath.Contains(`$pathToAdd)) {
      `$newPath = '{0}{1}{2}' -f `$oldPath, [IO.Path]::PathSeparator, `$pathToAdd;
      `$key.SetValue('Path', `$newPath, 'ExpandString');
  };
  `$key.Dispose();
  ; exit `$LASTEXITCODE;")
  $p = New-Object System.Diagnostics.Process;
  $p.StartInfo = $processInfo;
  $p.Start() | Out-Null;
  $stdout = $p.StandardOutput.ReadToEnd();
  $stderr = $p.StandardError.ReadToEnd();
  $p.WaitForExit();
  $stdout | Out-File -FilePath 'tmp' -Encoding utf8;
  exit $p.ExitCode;
  
```

❯ `windows::addToPath /coucou prepend=true`

**Standard output**:

```text
🙈 mocking powershell: -NoProfile -NonInteractive -Command 
  $ErrorActionPreference = 'Stop';
  $processInfo = New-Object System.Diagnostics.ProcessStartInfo;
  $processInfo.FileName = "powershell.exe";
  $processInfo.Verb = "runas";
  $processInfo.RedirectStandardError = $true;
  $processInfo.RedirectStandardOutput = $true;
  $processInfo.UseShellExecute = $false;
  $processInfo.CreateNoWindow = $true;
  $processInfo.Arguments = @("-NoProfile","-NonInteractive","-Command","`$ErrorActionPreference = 'Stop'; 
  `$pathToAdd = 'C:\Users\TEMP\coucou';
  `$key = [Microsoft.Win32.Registry]::CurrentUser.OpenSubKey('Environment', `$true);
  `$oldPath = `$key.GetValue('Path', '', 'DoNotExpandEnvironmentNames').TrimEnd([IO.Path]::PathSeparator);
  if (! `$oldPath.Contains(`$pathToAdd)) {
      `$newPath = '{0}{1}{2}' -f `$pathToAdd, [IO.Path]::PathSeparator, `$oldPath;
      `$key.SetValue('Path', `$newPath, 'ExpandString');
  };
  `$key.Dispose();
  ; exit `$LASTEXITCODE;")
  $p = New-Object System.Diagnostics.Process;
  $p.StartInfo = $processInfo;
  $p.Start() | Out-Null;
  $stdout = $p.StandardOutput.ReadToEnd();
  $stderr = $p.StandardError.ReadToEnd();
  $p.WaitForExit();
  $stdout | Out-File -FilePath 'tmp' -Encoding utf8;
  exit $p.ExitCode;
  
```

### ✅ Testing windows::createLink

❯ `windows::createLink resources/gitignored/file resources/gitignored/try/file2 hardlink=true`

**Standard output**:

```text
🙈 mocking fs::createLink: resources/gitignored/file resources/gitignored/try/file2 hardlink=true
```

❯ `windows::createLink resources/gitignored/file resources/gitignored/try/file2 hardlink=true`

**Standard output**:

```text
🙈 mocking powershell: -NoProfile -NonInteractive -Command 
    $ErrorActionPreference = 'Stop';
    $process = Start-Process -FilePath "powershell.exe" -ArgumentList @("-NoProfile","-NonInteractive","-File",'tmp') -Wait -Verb RunAs -WindowStyle Hidden;
    exit $process.ExitCode
    
```

❯ `windows::createLink resources/gitignored/try resources/gitignored/new`

**Standard output**:

```text
🙈 mocking powershell: -NoProfile -NonInteractive -Command 
    $ErrorActionPreference = 'Stop';
    $process = Start-Process -FilePath "powershell.exe" -ArgumentList @("-NoProfile","-NonInteractive","-File",'tmp') -Wait -Verb RunAs -WindowStyle Hidden;
    exit $process.ExitCode
    
```

