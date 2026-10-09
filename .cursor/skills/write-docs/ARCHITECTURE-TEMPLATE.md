# Architecture

How the system works now. Current state only; the reasons for choices are in [decisions](decisions.md).

## Overview

What the system is in two or three sentences, and where it runs: hosting, database, and external services.

## Parts

One bullet per part: its name, what it owns, and what it must not do. Link to its folder in [folder-structure](folder-structure.md) instead of repeating paths.

## Flows

One short section per flow that crosses parts, such as a request passing through auth to the database. Write a numbered list of steps, naming the part that does each step. Use a Mermaid flowchart only when a flow crosses three or more parts.

## Constraints

Limits a change must respect: performance, security, data ownership, platform limits, and anything the system must not do.
