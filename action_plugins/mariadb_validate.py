#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# SPDX-FileCopyrightText: 2025-2026 Thomas Vincent <thomasvincent@gmail.com>
# SPDX-License-Identifier: MIT

"""Custom Ansible action plugin for MariaDB validation."""

from ansible.plugins.action import ActionBase


class ActionModule(ActionBase):
    """Custom action plugin to validate MariaDB configuration parameters."""

    def run(self, tmp=None, task_vars=None):
        """Main entry point for the action plugin.

        Args:
            tmp: Temporary path (unused).
            task_vars: Dictionary of task variables passed by Ansible.

        Returns:
            dict: Result object with validation outcome.
        """
        result = super().run(tmp, task_vars)
        result.update(changed=False, failed=False)

        # Get module arguments
        root_password = self._task.args.get("root_password", "")
        secure_install = self._task.args.get("secure_install", True)

        # Perform validations
        errors = []

        if secure_install and not root_password:
            errors.append(
                "Root password must be set when secure installation is enabled"
            )

        # Report validation result
        if errors:
            result.update(
                failed=True,
                msg="; ".join(errors),
            )

        return result
