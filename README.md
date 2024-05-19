# CVE-2024-32002: Exploiting Git RCE via `git clone`

This repository contains a PoC for exploiting CVE-2024-32002, a vulnerability in Git that allows RCE during a `git clone` operation. By crafting repositories with submodules in a specific way, an attacker can exploit symlink handling on case-insensitive filesystems to write files into the `.git/` directory, leading to the execution of malicious hooks.

**Note:** This PoC will only work in Windows or Mac systems.

## Blog Post
For a detailed explanation of how this exploit was reversed, see the blog post: <https://amalmurali.me/posts/git-rce>.


## How It Works
1. A malicious repository (`git_rce`) includes a submodule with a specially crafted path.
2. The submodule path uses a case variation that exploits the case-insensitive filesystem.
3. The submodule includes a symlink pointing to its `.git/` directory, which contains a malicious hook.
4. When the repository is cloned, the symlink is followed, and the malicious hook is executed, leading to RCE.

## Repository Structure

- `git_rce/` (this repository): The main repository containing the submodule.
- [`amalmurali47/hook`](https://github.com/amalmurali47/hook): The submodule repository containing the malicious hook.

## Reproduction

⚠️ Warning: Do not run this PoC on systems you do not own or do not have explicit permission to use. Unauthorized testing could result in unintended consequences.

```bash
git clone --recursive git@github.com:amalmurali47/git_rce.git
```

Note: On Windows, you may need to run the shell as administrator for this to work.

### PoC execution on Windows
![](https://github.com/amalmurali47/blog/assets/3582096/e41d8e2e-81b6-4e68-a9e6-4489450c918d)


### PoC execution on Mac

![](https://github.com/amalmurali47/blog/assets/3582096/08d5c16c-c916-4d32-b49e-1ab0a0f0e789)


## Exploit Script

The script used to create the PoC is included in this repository as `create_poc.sh`. The instructions for setting up the PoC on a GitHub repo are included in the blog post.

## Disclaimer

This repository is for educational purposes only. The information provided here is intended to help developers understand the vulnerability and protect their systems. Do not use this exploit maliciously or without permission. Use of this PoC is at your own risk. The author is not responsible for any damages or legal issues that may arise from the use of this information.

## Acknowledgments

Credit to [filip-hejsek](https://github.com/filip-hejsek) for discovering this vulnerability. 

## License

This project is licensed under the MIT License.

