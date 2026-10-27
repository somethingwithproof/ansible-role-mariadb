# Contributing to Enterprise MariaDB Ansible Role

Thank you for your interest in contributing to this project! Here's how you can help.

## Code of Conduct

Please keep interactions respectful and professional.

## How Can I Contribute?

### Reporting Bugs

- Use the bug report template
- Include detailed steps to reproduce
- Specify your environment (OS, Ansible version, MariaDB version)

### Suggesting Features

- Use the feature request template
- Explain the use case for the feature
- Consider alternatives you've explored

### Pull Requests

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Run tests to ensure they pass (`molecule test`)
5. Commit your changes (`git commit -m 'Add some amazing feature'`)
6. Push to the branch (`git push origin feature/amazing-feature`)
7. Open a Pull Request

## Development Process

### Testing

We use Molecule for testing. Before submitting a PR, make sure all tests pass:

```
molecule test
```

### Code Style

- Follow Ansible best practices
- Keep tasks idempotent
- Use YAML syntax consistently with 2-space indentation
- Document your code with comments where necessary

## Release Process

Releases are created by tagging commits:

1. Update version in metadata if needed
2. Create a tag (`git tag -a v1.0.0 -m "Release v1.0.0"`)
3. Push the tag (`git push origin v1.0.0`)
4. GitHub Actions will create a release automatically

## Questions?

If you have any questions, feel free to open an issue or contact the maintainers.

## CI dependency locks and offline security checks

CI installs SHA-256-verified dependency locks from `requirements/`. Current
runtime jobs use `ci-ansible-14.5.0` on Python 3.13, including the seven-OS
`lts` scenario and the default, multi-instance, backup, monitoring and native
version-matrix contracts. Historical Ansible 9/10/12 locks retain their
original identities; they do not define current controller support.

Regenerate the new runtime lock with Python selected through `mise`:

```sh
mise exec python@3.13 -- uv pip compile requirements/ci-ansible-14.5.0.in --python-version 3.13 --python-platform x86_64-manylinux_2_35 --only-binary :all: --generate-hashes --output-file requirements/ci-ansible-14.5.0.txt
mise exec python@3.12 -- pre-commit run --all-files
mise exec python@3.13 -- python -m unittest discover -s tests/unit -v
mise exec python@3.13 -- molecule test -s lts
```

Install Docker Compose v2 as a Docker CLI plugin. The obsolete Python Compose
v1 package conflicts with the current PyYAML dependency and is not installed.

The offline tests substitute database and GitHub clients. They check failure
handling, exact-commit merge requests, and credential-file permissions without
contacting a server or changing an inventory. Run the named Molecule scenarios
in a deliberately selected disposable environment for deployment acceptance.

Backup and monitoring scripts contain rendered credentials and are root-only;
their template tasks redact output. Server configuration is readable by the
`mysql` group, and managed database directories exclude access by other users.
The development container runs as `mysql`. Bind mounts and existing data volumes
must already allow that user to access their contents; do not repair a live data
volume's permissions as part of routine development tests.

Dependabot merging runs after the named CI workflow completes, on its periodic
schedule, or on manual dispatch. It executes only trusted default-branch
metadata processing: it does not check out PR code or consume CI artifacts.
The GitHub API filters PR authors and supplies the exact commit passed to merge.
The current runtime lock includes Docker SDK 7.2.0. The backup directory is
managed only by backup tasks, preventing ownership oscillation. Review a new
Ansible major in a separately named environment with its required Python;
do not replace packages inside a differently named compatibility lock.
