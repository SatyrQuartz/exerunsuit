# Purpose
Runs a suitable software to run an .EXE file (Windows, DOS or OS/2) on Linux

# Binfmt setup
```bash
echo ':MZexec:M::MZ::/path/to/exerunsuit.sh:' | sudo tee /proc/sys/fs/binfmt_misc/register
```

# Software  
  wine (Windows emulator) - https://www.winehq.org/
  
  emu2 (DOS emulator) - https://github.com/dmsc/emu2
  
  2ine (OS2 emulator) - https://github.com/darkstar/2ine

  mono (.NET Framework) for architectures other than x86 or AMD64 - https://www.mono-project.com/
