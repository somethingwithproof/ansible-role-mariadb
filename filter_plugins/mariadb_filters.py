#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# SPDX-FileCopyrightText: 2025-2026 Thomas Vincent <thomasvincent@gmail.com>
# SPDX-License-Identifier: MIT

"""Custom Jinja2 filters for the mariadb role."""


class FilterModule:
    """Custom filters for the mariadb role."""

    def filters(self):
        return {
            "calculate_buffer_pool_size": self.calculate_buffer_pool_size,
            "normalize_mysql_privileges": self.normalize_mysql_privileges,
        }

    def calculate_buffer_pool_size(
        self, total_memory_mb, percentage=0.5, min_size_mb=128, max_size_mb=None
    ):
        """Calculate optimal InnoDB buffer pool size based on system memory.

        Args:
            total_memory_mb (int): Total memory in MB.
            percentage (float): Fraction to allocate to buffer pool.
            min_size_mb (int): Minimum size in MB.
            max_size_mb (int): Maximum size in MB, optional.

        Returns:
            str: Size string like '512M'.
        """
        calculated = int(total_memory_mb * percentage)

        if min_size_mb and calculated < min_size_mb:
            calculated = min_size_mb

        if max_size_mb and calculated > max_size_mb:
            calculated = max_size_mb

        return f"{calculated}M"

    def normalize_mysql_privileges(self, privileges):
        """Normalize MySQL privilege input to a consistent string format.

        Args:
            privileges (str|list): Privilege definition.

        Returns:
            str: Comma-separated privileges or fallback default.
        """
        if isinstance(privileges, str):
            return privileges

        if isinstance(privileges, list):
            return ",".join(privileges)

        return "*.*:USAGE"
