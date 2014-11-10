<?php

namespace SimpleUser;

use Symfony\Component\Security\Core\User\UserInterface;

/**
 * A simple User model.
 *
 * @package SimpleUser
 */
class User implements UserInterface, \Serializable
{
    protected $id;
    protected $login;
    protected $password;
    protected $salt;
    protected $roles = array();
    protected $name = '';
    protected $creationTime;

    /**
     * Constructor.
     *
     * @param string $login
     */
    public function __construct($login)
    {
        $this->login = $login;
        $this->creationTime = time();
        $this->salt = base_convert(sha1(uniqid(mt_rand(), true)), 16, 36);
    }

    /**
     * Returns the roles granted to the user. Note that all users have the ROLE_USER role.
     *
     * @return array A list of the user's roles.
     */
    public function getRoles()
    {
        $roles = $this->roles;

        // Every user must have at least one role, per Silex security docs.
        $roles[] = 'ROLE_USER';

        return array_unique($roles);
    }

    /**
     * Set the user's roles to the given list.
     *
     * @param array $roles
     */
    public function setRoles(array $roles)
    {
        $this->roles = array();

        foreach ($roles as $role) {
            $this->addRole($role);
        }
    }

    /**
     * Test whether the user has the given role.
     *
     * @param string $role
     * @return bool
     */
    public function hasRole($role)
    {
        return in_array(strtoupper($role), $this->getRoles(), true);
    }

    /**
     * Add the given role to the user.
     *
     * @param string $role
     */
    public function addRole($role)
    {
        $role = strtoupper($role);

        if ($role === 'ROLE_USER') {
            return;
        }

        if (!$this->hasRole($role)) {
            $this->roles[] = $role;
        }
    }

    /**
     * Remove the given role from the user.
     *
     * @param string $role
     */
    public function removeRole($role)
    {
        if (false !== $key = array_search(strtoupper($role), $this->roles, true)) {
            unset($this->roles[$key]);
            $this->roles = array_values($this->roles);
        }
    }

    /**
     * Set the user ID.
     *
     * @param int $id
     */
    public function setId($id)
    {
        $this->id = $id;
    }

    /**
     * Get the user ID.
     *
     * @return int
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * Get the encoded password used to authenticate the user.
     *
     * On authentication, a plain-text password will be salted,
     * encoded, and then compared to this value.
     *
     * @return string The encoded password.
     */
    public function getPassword()
    {
        return $this->password;
    }

    /**
     * Set the encoded password.
     *
     * @param string $password
     */
    public function setPassword($password)
    {
        $this->password = $password;
    }

    /**
     * Set the salt that should be used to encode the password.
     *
     * @param string $salt
     */
    public function setSalt($salt)
    {
        $this->salt = $salt;
    }

    /**
     * Returns the salt that was originally used to encode the password.
     *
     * This can return null if the password was not encoded using a salt.
     *
     * @return string The salt
     */
    public function getSalt()
    {
        return $this->salt;
    }

    /**
     * Returns the login, which serves as the username used to authenticate the user.
     *
     * This method is required by the UserInterface.
     *
     * @return string The username
     */
    public function getUsername()
    {
        return $this->login;
    }

    /**
     * @return string The user's login.
     */
    public function getLogin()
    {
        return $this->login;
    }

    /**
     * @param string $login
     */
    public function setLogin($login)
    {
        $this->login = $login;
    }

    /**
     * @param string $name
     */
    public function setName($name)
    {
        $this->name = $name;
    }

    /**
     * @return string
     */
    public function getName()
    {
        return $this->name;
    }

    /**
     * Returns the name, if set, or else "Anonymous {id}".
     *
     * @return string
     */
    public function getDisplayName()
    {
        return $this->name ?: 'Anonymous ' . $this->id;
    }

    /**
     * Set the time the user was originally created.
     *
     * @param int $creationTime A timestamp value.
     */
    public function setCreationTime($creationTime)
    {
        $this->creationTime = $creationTime;
    }

    /**
     * Set the time the user was originally created.
     *
     * @return int
     */
    public function getCreationTime()
    {
        return $this->creationTime;
    }

    /**
     * Removes sensitive data from the user.
     *
     * This is a no-op, since we never store the plain text credentials in this object.
     * It's required by UserInterface.
     *
     * @return void
     */
    public function eraseCredentials()
    {
    }

    /**
     * The Symfony Security component stores a serialized User object in the session.
     * We only need it to store the user ID, because the user provider's refreshUser() method is called on each request
     * and reloads the user by its ID.
     *
     * @see \Serializable::serialize()
     */
    public function serialize()
    {
        return serialize(array(
            $this->id,
        ));
    }

    /**
     * @see \Serializable::unserialize()
     */
    public function unserialize($serialized)
    {
        list (
            $this->id,
            ) = unserialize($serialized);
    }

    /**
     * Validate the user object.
     *
     * @return array An array of error messages, or an ampty array if there were no errors.
     */
    public function validate()
    {
        $errors = array();

        if (!$this->getLogin()) {
            $errors['login'] = 'Login is required.';
        }

        if (!$this->getPassword()) {
            $errors['password'] = 'Password is required.';
        } else if (strlen($this->getPassword()) > 255) {
            $errors['password'] = 'Password can\'t be longer than 255 characters.';
        }

        if (strlen($this->getName()) > 100) {
            $errors['name'] = 'Name can\'t be longer than 100 characters.';
        }

        return $errors;
    }

}